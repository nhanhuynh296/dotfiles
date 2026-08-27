# `brew shellenv` (run from .zprofile) EXPORTS FPATH. Inherited by child shells,
# that made $fpath grow -- and even once deduped, reorder -- between nesting
# levels. OMZ stamps "$fpath" into ~/.zcompdump-* and rebuilds the whole dump
# when the string differs, which cost a ~430ms compinit on the next shell start.
# Dedupe, then unexport so every shell derives $fpath identically from scratch.
typeset -U path fpath
typeset +x FPATH

# compaudit reports no insecure completion dirs on this machine; skip the check.
ZSH_DISABLE_COMPFIX=true
