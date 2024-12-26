<?php

namespace MyNamespace\MyTheme;

use Exception;
use RuntimeException;

/**
 * Autoloader for the theme classes and interfaces to be loaded dynamically.
 * This will allow us to include only the files we need when we need them.
 *
 * @param string $className The name of the class to load
 * @return void
 * @package WordPress\Ppfeufer\Plugin\WpMemoryUsage
 */
spl_autoload_register(callback: static function (string $className): void {
    // Check if the class name starts with the base namespace or includes `Libs' in the path
    if (!str_starts_with(haystack: $className, needle: __NAMESPACE__)
        || str_contains(haystack: $className, needle: '\Libs')) {
        return;
    }

    // Convert the class name to a relative file path
    $relativeClass = str_replace(
        [
            __NAMESPACE__ . '\\',
            '\\'
        ],
        [
            '',
            DIRECTORY_SEPARATOR
        ],
        $className
    );

    // Construct the full file path
    $file = __DIR__ . DIRECTORY_SEPARATOR . $relativeClass . '.php';

    // Include the file if it exists
    try {
        if (file_exists($file)) {
            include_once $file;
        } else {
            throw new RuntimeException(
                sprintf(
                    'Autoloader error: Class file for %1$s not found at %2$s',
                    $className,
                    $file
                )
            );
        }
    } catch (Exception $e) {
        error_log($e->getMessage());
    }
});
