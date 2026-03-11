/**
 * PocketBase Startup Hook
 * Initializes application settings on boot
 */

// Hook that runs when the app is bootstrapped
onBootstrap((e) => {
  e.next();

  console.log("Initializing PocketBase settings...");

  try {
    // Get settings
    var settings = $app.settings();

    // Get app name from environment or use default
    var appName = $os.getenv("APP_NAME");
    
    // Update application settings
    settings.meta.appName = appName;
    settings.meta.hideControls = true;

    // Save settings
    $app.save(settings);
    console.log("Set PocketBase default settings...");
  } catch (error) {
    console.error("Failed to initialize settings: " + error.message);
    throw error;
  }
});
