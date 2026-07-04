lib_sources = files('vala-library-template.vala')

vala_library_template_lib = shared_library(
  'vala-library-template',
  lib_sources,
  dependencies: [dependency('glib-2.0'), dependency('gio-2.0'), dependency('libsoup-3.0')],
  install: true,
  vala_vapi: 'vala-library-template.vapi',
  vala_header: 'vala-library-template.h'
)

vala_library_template_dep = declare_dependency(
  link_with: vala_library_template_lib,
  include_directories: include_directories('.'),
  sources: vala_library_template_lib.private_dir_shape()
)

pkg = import('pkgconfig')
pkg.generate(
  vala_library_template_lib,
  version: '1.0',
  name: 'vala-library-template',
  filebase: 'vala-library-template',
  description: 'Vala Library Template.'
)
