lib_sources = files(
  'testcases.vala',
)

vala_testcases_deps = [
  dependency('glib-2.0'),
  dependency('gee-0.8'),
]

vala_testcases_lib = shared_library(
  'vala_testcases',
  lib_sources,
  dependencies: vala_testcases_deps,
  install: true,
  vala_vapi: 'vapi/vala_testcases.vapi',
  vala_header: 'vala_testcases.h'
)

vala_testcases_dep = declare_dependency(
  link_with: vala_testcases_lib,
  include_directories: include_directories('.'),
  sources: lib_sources
)

pkg = import('pkgconfig')
pkg.generate(
  vala_testcases_lib,
  version: '1.0',
  name: 'vala_testcases',
  filebase: 'vala_testcases',
  description: 'Vala Test cases.'
)
