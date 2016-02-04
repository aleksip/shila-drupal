<?php

/**
 * @file
 * shila-drupal/d8/drush/site-aliases/local.d8.aliases.drushrc.php
 */

$sites = [
  'shila' => 'www.shila.dev',
];

foreach ($sites as $alias => $uri) {
  $aliases[$alias] = [
    'uri' => $uri,
    'root' => '/var/www/shila-prod/code/shila-drupal/d8/web',
    'path-aliases' => [
      '%dump-dir' => '/var/www/shila-prod/data/sql-dumps',
    ],
  ];
}
