class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    background_image = UIImage.imageNamed('back_drop')
    #@window.rootViewController = ParallaxNavigation.new(Screen1Controller.new, background_image)
    #@window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    true
  end
end