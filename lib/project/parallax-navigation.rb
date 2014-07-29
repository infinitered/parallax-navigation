class ParallaxNavigation
  attr_reader :navigation
  PADDING = 1.5
  PARALLAX_DISTANCE = 0.2

  def initialize (start_controller, background_image, duration = 0.5)
    @navigation = UINavigationController.alloc.initWithRootViewController(start_controller)
    @navigation.delegate = self
    @duration = duration
    create_parallax_background(background_image)
  end

  def create_parallax_background background_image
    @background = UIImageView.alloc.initWithImage(background_image)
    #stick it at the bottom of the Z stack
    @navigation.view.insertSubview(@background, atIndex: 0)
  end

  # Required by iOS7 UIViewControllerAnimatedTransitioning
  def transitionDuration transitionContext
    @duration
  end

  # Required by iOS7 UIViewControllerAnimatedTransitioning
  def animateTransition transitionContext

    # change direction
    case @operation
    when UINavigationControllerOperationPush
      delta = rmq.device.width * PADDING
      parallax = @background.layer.contentsRect.origin.x + PARALLAX_DISTANCE
    else
      delta = -rmq.device.width * PADDING
      parallax = @background.layer.contentsRect.origin.x - PARALLAX_DISTANCE
    end

    #Animate existing layer away + remove
    rmq(@from_vc.view).animate(
      duration: @duration,
      animations: ->(cq) {
        cq.style do |st|
          st.left = -delta
        end
      },
      completion: -> (did_finish, q) {
        # clear on out
        @from_vc.view.removeFromSuperview
      }
    )

    # #rmq($junk.view.backgroundView).animate(duration: 1.0, animations: -> (cq) { cq.get.layer.contentsRect = CGRectMake(cq.get.layer.contentsRect.origin.x + 0.1, 0, 1,1) })
    rmq(@background).animate(
      duration: @duration,
      animations: -> (cq) {
        cq.get.layer.contentsRect = CGRectMake(parallax, 0, 1,1)
      }
    )

    # Put the new view off to the right side
    rmq(@to_vc.view).move(l: delta)
    # First add our new subview
    transitionContext.containerView.addSubview(@to_vc.view)

    # Animate new view into place + completeTransition
    rmq(@to_vc.view).animate(
      duration: @duration,
      animations: ->(cq) {
        cq.style do |st|
          st.left = 0
        end
      },
      completion: -> (did_finish, q) {
        #relinquish animation state
        transitionContext.completeTransition(true)
      }
    )

  end

  # Navigation controller delegate
  def navigationController(navigationController, animationControllerForOperation:operation, fromViewController:from_vc, toViewController:to_vc)
    @navigation = navigationController
    @operation = operation
    @from_vc = clear_background(from_vc)
    @to_vc = clear_background(to_vc)

    self
  end


  def clear_background(vc)
    vc.view.backgroundColor = rmq.color.clear
    vc.view.backgroundView = nil if vc.view.is_a?(UITableView)

    vc
  end


end