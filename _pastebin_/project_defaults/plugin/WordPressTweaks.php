<?php
/**
 * My Plugin
 *
 * A collection of personal tweaks for WordPress.
 *
 * @package MyNamespace\MyPlugin
 * @author H. Peter Pfeufer
 * @copyright 2021 H. Peter Pfeufer
 * @license GPL-3.0-or-later
 * @version 1.0.0
 *
 * @wordpress-plugin
 * Plugin Name: My Plugin
 * Plugin URI:
 * Description: My Plugin Description
 * Version: 1.0.0
 * Requires at least: 6.0
 * Requires PHP: 8.2
 * Author: H. Peter Pfeufer
 * Author URI: https://ppfeufer.de
 * Text Domain: my-plugin
 * Domain Path: /l10n
 * License: GPLv3
 * License URI:
 */

namespace MyNamespace\MyPlugin;

// phpcs:disable
// Plugin directory path
define(
    constant_name: __NAMESPACE__ . '\PLUGIN_DIR_PATH',
    value: plugin_dir_path(file: __FILE__)
);

// Plugin directory relative path
define(
    constant_name: __NAMESPACE__ . '\PLUGIN_REL_PATH',
    value: dirname(plugin_basename(__FILE__))
);

// Plugin directory URL
define(
    constant_name: __NAMESPACE__ . '\PLUGIN_DIR_URL',
    value: plugin_dir_url(file: __FILE__)
);

// Plugin basename
define(
    constant_name: __NAMESPACE__ . '\PLUGIN_BASENAME',
    value: plugin_basename(file: __FILE__)
);

// Plugin source path
const PLUGIN_SOURCE_PATH = PLUGIN_DIR_PATH . 'Sources/';

// Include the autoloader and the libraries autoloader
require_once PLUGIN_SOURCE_PATH . 'autoloader.php';
require_once PLUGIN_SOURCE_PATH . 'Libs/autoload.php';
// phpcs:enable

// Load the plugin's main class.
new Main();
