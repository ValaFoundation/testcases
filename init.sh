#!/usr/bin/env bash
set -euo pipefail

# Colors for better terminal output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}==> Initializing Vala Library Template manager for Vala...${NC}"

# 1. Check if the user is running the script in the root of a Meson project
if [ ! -f "meson.build" ]; then
    echo -e "${RED}[Error] 'meson.build' file not found in the current directory.${NC}"
    echo -e "Make sure you are running this script in the root folder of your Vala application."
    exit 1
fi

# 2. Create the subprojects folder if it doesn't exist yet
if [ ! -d "subprojects" ]; then
    echo -e "Creating ${BLUE}subprojects/${NC} directory..."
    mkdir "subprojects"
fi

# 3. Generate the .wrap file
WRAP_FILE="subprojects/vala-library-template.wrap"
echo -e "Generating wrap file ${BLUE}${WRAP_FILE}${NC}..."

cat << 'EOF' > "$WRAP_FILE"
[wrap-git]
url = https://github.com/JanGalek/vala-library-template.git
revision = v1.0.0
depth = 1

[provide]
dependency_name = vala-library-template
EOF

echo -e "${GREEN}[Done] Wrap file has been successfully created.${NC}\n"

# 4. Instructions for the developer on how to proceed
echo -e "${BLUE}Now edit your main 'meson.build' and add the dependency:${NC}"
echo -e "--------------------------------------------------------"
echo -e "vala-library-template_dep = dependency('vala-library-template', fallback: ['vala-library-template', 'vala-library-template_dep'])"
echo -e ""
echo -e "executable("
echo -e "  'your-binary-name',"
echo -e "  'your-source-files.vala',"
echo -e "  dependencies: [ dependency('glib-2.0'), dependency('gio-2.0'), ${GREEN}vala-library-template_dep${NC} ]"
echo -e ")"
echo -e "--------------------------------------------------------"
echo -e "Then just build the project using: ${GREEN}meson setup build && meson compile -C build${NC}"