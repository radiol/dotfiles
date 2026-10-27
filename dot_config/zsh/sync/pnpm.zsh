# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
# pnpm v10 uses $PNPM_HOME as global bin dir, v11+ uses $PNPM_HOME/bin
for _pnpm_bin in "$PNPM_HOME/bin" "$PNPM_HOME"; do
  case ":$PATH:" in
    *":$_pnpm_bin:"*) ;;
    *) export PATH="$_pnpm_bin:$PATH" ;;
  esac
done
unset _pnpm_bin
# pnpm end
