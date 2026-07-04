lib_sources = files(
  'testcases.vala',
)

vala_lib_deps = [
  dependency('glib-2.0'),
  dependency('gee-0.8'),
]

vala_testcase = shared_library(
  'vala_testcases',
  lib_sources,
  dependencies: vala_lib_deps,
  install: true,
  vala_vapi: 'vala_testcases.vapi',
  vala_header: 'vala_testcases.h'
)

vala_testcase_dep = declare_dependency(
  link_with: vala_testcase,
  include_directories: include_directories('.'),
  sources: lib_sources
)

pkg = import('pkgconfig')
pkg.generate(
  vala_testcase,
  version: '1.0',
  name: 'vala_testcases',
  filebase: 'vala_testcases',
  description: 'Vala Test cases.'
)
