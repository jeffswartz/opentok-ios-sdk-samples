Project 1: Hello World
======================

The Hello World app is a very simple application meant to get a new developer
started using the OpenTok iOS SDK.

Application Notes
-----------------

1.  Follow the code from the `[UIViewController viewDidLoad:]` method through
    to the OpenTok callbacks to see how streams are created and handled in
    the OpenTok iOS SDK.

2.  In the VideoController.m file, set values for the `kApiKey`, `kSessionId`,
    and `kToken` constants. For testing, you can obtain these values at the
    [OpenTok dashboard][1]. In a production application, use one of the
    [OpenTok server SDKs][2] to generate session IDs and tokens.
    
3.  By default, all delegate methods from classes in the OpenTok iOS SDK are
    invoked on the main queue. This means that you can directly modify the view
    hierarchy from inside the callback, without any asynchronous callouts.

4.  Use the browser-demo.html file (in located in the root directory of this
    project), to connect to the OpenTok session and publish an audio-video
    stream from a web browser:

    * Edit browser-demo.html file and modify the variables `apiKey`,
      `sessionId`, and `token` with your OpenTok API Key, and with the matching
      session ID and token. (Note that you would normally use the OpenTok
      server-side libraries to issue unique tokens to each client in a session.
      But for testing purposes, you can use the same token on both clients.
      Also, depending on your app, you may use the OpenTok server-side
      libraries to generate new sessions.)

    * Add the browser_demo.html file to a web server. (You cannot run WebRTC
      video in web pages loaded from the desktop.)

    * In a browser, load the browser_demo.html file from the web server. Click
      the Connect and Publish buttons. Run the app on your iOS device to send
      and receive streams between the device and the browser.


Configuration Notes
-------------------

1.  In the Project Navigator in XCode, notice the additional system frameworks
    needed for this project. If a framework is missing, you will see linker 
    errors while attempting to build the SDK. Frameworks can be added in the
    "Link binary with libraries" phase, in the "Build Phases" tab of the
    application target. For example, removing OpenTok.framework from the linker 
    phase results with the following error when you attempt to build the
    application:
    
    ```
Undefined symbols for architecture armv7:
  "_OBJC_CLASS_$_OTSubscriber", referenced from:
      objc-class-ref in ViewController.o
  "_OBJC_CLASS_$_OTPublisher", referenced from:
      objc-class-ref in ViewController.o
  "_OBJC_CLASS_$_OTSession", referenced from:
      objc-class-ref in ViewController.o
    ```

2.  OpenTok uses GNU's libstdc++, which differs from the default C++ standard
    library for new projects in XCode (LLVM's libc++). You'll notice that
    `libstdc++.6.0.9.dylib` is in the binary linker phase, rather than the more-
    forgiving symlink `libstdc++.dylib`. In our tests, the symlinks did not work
    as the direct reference to the dylib, so long as the application deployment
    target is 7.0. Using an earlier deployment target might work for you, if the
    direct library reference is not suitable for your application.
    
3.  You can test in the iOS Simulator or on a supported iOS device. However, the
    XCode iOS Simulator does not provide access to the camera. When running in
    the iOS Simulator, an OTPublisher object uses a demo video instead of the
    camera.

[1]: https://dashboard.tokbox.com/projects
[2]: https://tokbox.com/opentok/libraries/server/