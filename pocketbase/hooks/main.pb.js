/**
 * PocketBase Startup Hook
 * Initializes application settings on boot
 */

// Hook that runs after the app is bootstrapped
onAfterBootstrap((e) => {
  console.log("Initializing PocketBase settings...");

  try {
    // Get settings
    var settings = $app.Settings();

    // Get app name from environment or use default
    var appName = $os.Getenv("APP_NAME") || "PocketBase";
    
    // Update application settings
    settings.Meta.AppName = appName;
    settings.Meta.SenderName = appName;
    settings.HideCollectionCreate = true;
    settings.HideCollectionEdit = true;

    // Save settings
    $app.Save(settings);
  } catch (error) {
    console.error("Failed to initialize settings: " + error.message);
    throw error;
  }
});
