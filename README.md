# Testcases

A small Vala helper library for writing and registering GLib tests with less boilerplate.

## Contents

- [Features](#features)
- [Public API (summary)](#public-api-summary)
- [Example test suite](#example-test-suite)
- [Use In Other Projects](#use-in-other-projects)
- [Quick init (dependency setup)](#quick-init-dependency-setup)
- [Build](#build)
- [Test](#test)
- [Dependencies](#dependencies)
- [License](#license)

## Features

- Simple base class for test registration
- Wrapper for registering test suites by type
- Compatible with GLib test runner (`Test.run()`)
- Designed for Meson subproject integration

## Public API (summary)

Namespace: `ValaFoundation.Testcases`

- `BaseTest`
  - `add_test(string name, owned TestCommand.TestMethod method)`
- `register_test_suite<T>()`

## Example test suite

```vala
using GLib;
using Gee;

namespace AppTests {
	using ValaFoundation.Testcases;

	public class ExampleTest : BaseTest {
		construct {
			add_test ("math", test_math);
			add_test ("text", test_text);
		}

		public void test_math () {
			assert (1 + 1 == 2);
		}

		public void test_text () {
			assert ("vala".length == 4);
		}
	}
}

int main (string[] args) {
	ValaFoundation.Testcases.BaseTest.saved_commands = new Gee.ArrayList<ValaFoundation.Testcases.TestCommand> ();
	Test.init (ref args);
	ValaFoundation.Testcases.register_test_suite<AppTests.ExampleTest> ();
	return Test.run ();
}
```

## Use In Other Projects

Yes. The generated artifacts are intended for reuse:

- `build-release/src/libvala_testcases.so*`
- `build-release/src/vapi/vala_testcases.vapi`
- `build-release/src/vala_testcases.h`

### Option 1: Meson subproject (recommended)

In your consumer project `meson.build`:

```meson
vala_testcases_dep = dependency('vala_testcases', fallback: ['vala_testcases', 'vala_testcases_dep'])

executable('my-tests',
  ['tests/main.vala', 'tests/example_test.vala'],
  dependencies: [dependency('glib-2.0'), dependency('gee-0.8'), vala_testcases_dep],
)
```

Then in Vala code:

```vala
using ValaFoundation.Testcases;
```

### Option 2: Installed library (pkg-config)

Install this project first:

```sh
meson setup builddir
meson compile -C builddir
meson install -C builddir
```

In your consumer `meson.build`:

```meson
vala_testcases_dep = dependency('vala_testcases', method: 'pkg-config')
```

### Option 3: Local vapi folder in your project

If you want everything vendored inside your own repository, copy release artifacts into your consumer project, for example:

- `your-project/vapi/vala_testcases.vapi`
- `your-project/lib/libvala_testcases.so`
- `your-project/include/vala_testcases.h`

To automate this setup, run the helper script in your consumer project root:

```sh
curl -sSfL https://raw.githubusercontent.com/ValaFoundation/testcases/master/init-local-vapi.sh | bash
```

The script will:

- download a prebuilt release ZIP when available (fast path)
- fallback to building `vala-testcases` from source when release assets are unavailable
- copy artifacts into your local `vapi/`, `lib/`, and `include/` directories
- append an idempotent helper block to your `meson.build` with reusable variables

You can also run it from a local file copy:

```sh
./init-local-vapi.sh
```

Then configure your consumer `meson.build`:

```meson
executable('my-tests',
	['tests/main.vala', 'tests/example_test.vala'],
	dependencies: vala_testcases_local_deps,
	vala_args: vala_testcases_local_vala_args,
	c_args: vala_testcases_local_c_args,
	link_args: vala_testcases_local_link_args,
)
```

And load the shared library at runtime, for example:

```sh
LD_LIBRARY_PATH=./lib ./my-tests
```

## Quick init (dependency setup)

To add `vala-testcases` as a Meson subproject dependency, run:

```sh
./init.sh
```

Or run it directly from GitHub:

```sh
curl -sSfL https://raw.githubusercontent.com/ValaFoundation/testcases/refs/heads/master/init.sh -o init.sh && chmod +x init.sh && ./init.sh && rm init.sh
```

For local vendored integration without subprojects, use:

```sh
curl -sSfL https://raw.githubusercontent.com/ValaFoundation/testcases/master/init-local-vapi.sh | bash
```

## Build

```sh
meson setup builddir
meson compile -C builddir
```

## Test

```sh
meson test -C builddir
```

or via Makefile helper:

```sh
make tests
```

## Dependencies

- glib-2.0
- gee-0.8

In consumer projects, use:

```meson
vala_testcases_dep = dependency('vala_testcases', fallback: ['vala_testcases', 'vala_testcases_dep'])
```

Then add `vala_testcases_dep` to your target dependencies.

## License

MIT (see `LICENSE`).
