function find_wrong_files() {
  local FILE="$*"
  local FILE_TYPE
  FILE_TYPE=$(file --mime-type "$FILE" | awk '{print $2}')
  local MAIN_TYPE=${"$FILE_TYPE"%/}
  local SUB_TYPE=${"$FILE_TYPE"#/}
  case "$MAIN_TYPE" in
  "text")
    return
    ;;
  "inode")
    case "$SUB_TYPE" in
    "x-empty"|"directory"|"symlink")
      return
      ;;
    esac
    ;;
  "application")
    case "$SUB_TYPE" in
    "json"|"csv")
      return
      ;;
    esac
    ;;
  "image")
    case "$SUB_TYPE" in
    "svg+xml")
      return
      ;;
    esac
    ;;
  esac
  WRONG_FILES="$WRONG_FILES\n$FILE"
}
