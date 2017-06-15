api = 2
core = 6.x
projects[drupal][type] = core
projects[drupal][version] = 6.38
projects[drupal][download][type] = get
; https://github.com/pressflow/6/releases
projects[drupal][download][url] = "https://github.com/pressflow/6/archive/pressflow-6.38.121.tar.gz"
; Reverse Proxy Patch
; https://www.drupal.org/node/466444
projects[drupal][patch][] = "http://drupal.org/files/issues/common.inc_6.30.patch"
