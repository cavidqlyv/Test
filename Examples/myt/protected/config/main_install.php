<?php

return array(
    'basePath' => dirname(__FILE__) . DIRECTORY_SEPARATOR . '..',
    'name' => 'MyT Installer',
    'defaultController' => 'install/index',
    // preloading 'log' component
    'preload' => array('log'),
    // autoloading model and component classes
    'import' => array(
        'application.models.*',
        'application.components.*',
    ),
    // i18n
    'language' => 'en',
    'sourceLanguage' => 'en',
    'theme' => 'fluid',
    // application components
    'components' => array(
        'widgetFactory' => array(
            'widgets' => array(
                'CLinkPager' => array(
                    'cssFile' => false,
                    'header' => false
                )
            )
        ),
        'cache' => array(
            'class' => 'system.caching.CFileCache',
        ),
        'errorHandler' => array(
// use 'site/error' action to display errors
            'errorAction' => 'site/error',
        ),
        'log' => array(
            'class' => 'CLogRouter',
            'routes' => array(
                array(
                    'class' => 'CFileLogRoute',
                    'levels' => 'error, warning',
                ),
            // uncomment the following to show log messages on web pages
            /*
              array(
              'class'=>'CWebLogRoute',
              ),
             */
            ),
        ),
        'format' => array(
            'class' => 'ELocalizedFormatter',
        ),
        'messages' => array(
            'class' => 'CPhpMessageSource',
            'forceTranslation' => true,
            'language' => 'en',
        ),
    ),
);
