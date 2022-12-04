#!/bin/bash
skip=50
set -e

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

lziptmpdir=
trap 'res=$?
  test -n "$lziptmpdir" && rm -fr "$lziptmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | */tmp/) test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  */tmp) TMPDIR=$TMPDIR/; test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  *:* | *) TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
esac
if type mktemp >/dev/null 2>&1; then
  lziptmpdir=`mktemp -d "${TMPDIR}lziptmpXXXXXXXXX"`
else
  lziptmpdir=${TMPDIR}lziptmp$$; mkdir $lziptmpdir
fi || { (exit 127); exit 127; }

lziptmp=$lziptmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$lziptmp" && rm -r "$lziptmp";;
*/*) lziptmp=$lziptmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | lzip -cd > "$lziptmp"; then
  umask $umask
  chmod 700 "$lziptmp"
  (sleep 5; rm -fr "$lziptmpdir") 2>/dev/null &
  "$lziptmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n%s\n' "Cannot decompress ${0##*/}" "Report bugs <fajarrkim@gmail.com>"
  (exit 127); res=127
fi; exit $res
LZIP �BF=�j�g�z�I���,;eb����YqC�gtJ��8�<d�����Gq���	c9ΦB�4z�ߵ��[�T9N`�xf��G��;[�T�@�d6�>Ec^gs���� ��*��Ή>�J��h��	�6��'e�8����;��&��l�#3R�x��<�^�>S9�":dQ_ɝud�:WeC�ذVt���GF����x�B�uX~f]����s.=P���m��T�GƗ:5'q�[۴AZe�#����w��@>;���p@$���J��Σ��=���&�Z�Z�w���oR�'��6�0?$�`��B3f�'}�]��^7|E�HUu?��;�/i��y�|s&dD��2^��?=,%�'#(��x�4�v?E�� .�so�e��&v�*��=|���b6��%��u�mZ�����G��R(E��
/Eh�,8e�ɧ�}��e>�F�A�&b
���4o���D�L�WC�\��`-�;�B��_;!1QV��=��W$�dX�,]��g��2]}�V��e�G=C���Lb�iB";�L(|E��)Sy�ش����G�-$��0���Ř'�2�]ͭ�os��D�鷫�F�"��y8���F�r-.�!r����-��"�(�4A����T~0Sqͧ^)�V�v� ��"[-^B��j,�L��N|msh�DOlƴĊS-%�!)Y��׾���Rk#+�Ʃ�[�l�6d��v������?� 4��k?4{�>c� Ql��t9qDrHFn�������|S�"'�B�z�O��7cFg*��p��������]k��o�fFS�e!D���I�L�O�I��Z���&�pg%�怗��i���Y��������f �i�Xl�.���������$��}�V��a)��!4mQr4ץz����߿��v�+].	v�,-{�|-I�qD��|Q����ȄE6��IU3:ZYSw�Ud�<K��Zz*q�����C�A�
�ɨQѻ�����d� ��8@����+���A�Э1[�AB�l���Ie�B�"9ҽ�kˍx.�Fy�~S8�~7�%��ُ�h-��u|M ��{zŪ�=o�N"��AE��Y5Zq�ޜ������ϴ�l�ѥ>egEh��u���Kg��$�c�q=��k02Xbi�I���ֺ--PO�	;�E2���߽W�"���,�
�i+E/F>��7���k��-�$J?*n�� L"C���1<)��\n7.�Q�*2��0R��n�Fa݂����J�HJ$;b<����ת Q`�"��_�q��<-�s+�P��$=ZfA ÁA�u)K�~���h�Kp[-%
��ٛ�E<������K�;*�vL�Q����k�7AhK�*,,�����������4K\�fe�f������15��:�H�HXk��i�>It�8:\��!{�K��(�3��v��˕/�^xɭ`���D���l����].�b��z՞��ϑcM��v:MC𴹒.�d;��TE��W�6A�cS�ާ��r�`Q�<�<+���;�)0��L�0������R��/)����ר���p�1�Vh��`��s,�<Uv���^�� �3��I���/S��C.��큡������%��}N��?[�h`!�D��f�3��_�^G��$pU���ǀ��J\	���G4�Z�H�&h���s�"Ӛ��|���G=e��$��^ 7/���J��\$h�m�c�,���� y��1x�U�2u�޷D�G4�jP��#��7$bӶ����_�\��2������G�����y�ݱ�Y�G8��g��ȵkw�<�q���7mQ#��7Y��Mӭ�,/�֤���Vwz>
���/q݈L�9�u@��<���[[������G�x�!��l��2Z���I�Ѭ�q�[k3X��%DT��T��I�q���U9l��5��ث�\���7�) 1q'��#�x�a��3�`��|�s��zt�1� ��������ڥ Xi��w�'d���*}&�t�����h����&��C�Z;���?�ލh8��Ҧ?�
:@% pe�c0�L{W�Ѧ�H�{Dk�=����e|�Q㺿���ષ%��&$��\Cu�P��^�<�/�C��%3���Q�,O��U��V~K�������4+r�ͩ�cQ �-(�R��hh6����>������-Ǝv1      �      