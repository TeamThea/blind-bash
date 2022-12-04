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
LZIP� �BF=�j�g�z�I���,;eb����YqC�gtJ��8�<d�����Gq���	c9ΦB�4z�ߵ��[�T9N`�xf��G��;[�T�@�d6�>Ec^gs���� ��*��Ή>�J��h��	�6��'e�8����;��&��l�#3R�x��<�^�>S9�":dQ_ɝud�:WeC�ذVt���GF����x�B�uX~f]����s.=P���m��T�GƗ:5'q�[۴AZe�#����w��@>;���p@$���J��Σ��=���&�Z�Z�w���oR�'��6�0?$�`��B3f�'}�]��^7|E�HUu?��;�/i��y�|s&dD��2^��?=,%�'#(��x�4�v?E�� .�so�e��&v�*��=|���b6��%��u�mZ�����G��R(E��
/Eh�,8e�ɧ�}��e>�F�A�&b
���4o���D�L�WC�\��`-�;�B��_;!1QV��=��W$�dX�,]��g��2]}�V��e�G=C���Lb�iB";�L(|E��)Sy�ش����G�-$��0���Ř'�2�]ͭ�os��D�鷫�F�"��y8���F�"J�/�t��Z5�!xn�H� ����{�&v	�c��¸�,��'K��HQ�O�x�2}�a�5������:��a}2^�ɠ˝l_�1V_~m�b3�A���@@bg�������S!G�,�6�e?*���T���~�Q�i7d}�9��'b���Gz�\�WE�x�ѨY��:[�`6כE3ſ����p)�H.�õ�0�S�L�A��g�Ί�o�"e-�^���D�����Y7O~�=��o���"�@N�6��z����@o�揂f��+���)%��=�:���>\����V�ܠ��["�vx��pTuå:�=*����Z�;���ME����(�l��Ø�M}z`<f7�$��a��4�M�C��ϵ��5gݩ�߆	d[�HvY�և�)A5c�N�&;9��{��+�����mw0{x�������/$ů��	x��Cnl.3����S�{_���l���c5�U��]ǩh7�D�Ӡ#Ģ��p�9����b	��0x��(f)�
z`�܃w9n}~LZH�W�v�������n���3���U3���U%+�E�8W�d�_$�<h�����e�Лj�6�+k�W���b�x��
�ݨ�ot:}��h�9j�G�����&@C�j�)�H%��R��@����ܲI�<W<!R<0
�G�-�؂�L�J���-2D�6@|+���V��|�*�wAq���2`A����z8��HV��~�C�wq'?��H�݊�vm:�V��;���]$�)���#���mE��Ч�Z�R�r��;D8[���Ea��]�z��&�Ly)�Z�D/.�-�������"� 7Ԕ���Lbr�{�_D+�d}L�rG:H�]/��}�~-��1��,L�X�3��@��U|%�V��Mj&�'8��O�`��k�����E ��f�Rmo+����͉�UQ�ĩy%čS�,��G:Kg�|�[�k��U����,�6D�}���\	c^>�T+Y�n^�Y����)�j����[N�P{R��V����d|���o�)8��"[��ct/N�0�x`j<�'��|w��᧶�_K��d��Y}>-�Q|�K�1��+R3v@C�ӆt]�K}��u�wa��f�S�)1��j�Y@�R"Qs�h9�_C�:�/jy�]�E78Dw��2xk�9�|nT��w��yᑦ7��K!��N�>�/>W��K�E 0���M�b�=��NI�']ӧׇ46��U�Z2JܙH�O��%���M��ܯ�b��0�,�ܾ2�b�����=�.K@X�~A\z- �<OCDR�U]8����ax�L&��J1ɋ4�X���[�C��k������$�k�/�4�K�	�-ǡŢ����t�K��K�X՞~�#<���'��������>�Q͛!�i$�rU���9H��Ǥat��l�������mj�P�vH+>�{s%,G-b5a�hQ[Q���w+�ze)FL *Dy�,�h�R�g]H+���T1ԒD�-��Uk\[�`7�מ�J��fq[�N$.B6�� ��'X�=Q3�^�7X�eo���2�S�<��ʒ�І<��S��\�UBj-��,���X0���I< 4�
�gsr,�[	ĉ����t	O����� 6���6=M�n�Ȟ�.E+26ǧ��z�Z��.hu5Q��w�q��v
5�w�/ �6�,V)Q!�i�.B\�S���sŘQނ �*l�rR:��q���{���|�AZ5�D���G�"*�ƝUO�.��J�ZK��I���Ț5�ƛ���M�J��-ࣙ�(g>~�縤��w�dd fC�+p����V���b�5���ãٯ�J.��y������cΓ�o�ݾ�\�@m|�r���K�OM��Lr��ު���/��|� ���|��+r)IݭU��[h��N����q��ݝ6���q�c Ɔ@3uj�%��·@9�>=��Bk&���V[�D�cw�����r�\�h��{T�R�W�y6߽���n�&�3�+��)��0��QK�}�k_�b?��5�{T��T��z9��9��@�A'���Pc�+��;j>d�"y�Q�`��x�&%`�a	�E��ծlC�S���M*a��a_sF�e�z���AZ�նn��n��T���p�#B��������fb�5��3�����(�]R��e+U�
���Ϥ�/�>�d�S�(�Sj�m�o�`4��L���0�0э�[V��E��t`ݸ
�e������	���⺕ǵlqt�(^�R_,���f���/}�����}`x�i����&q1:p����-�i��	���wm���z1֪������uё��m��@&�C�e���[wF�:�f,� �"��+���+��h9Pt�Ѧ�dt�@fAX;~RAޓ.j��EZX�SH�@�ܽq�6����&l�r��љ���{9:����t��:��͞P�TB�sl�!.nf&�5�7h��G����`���$����"d�	qAFR,�=��M�0�!�p�9G����ߣC�	\��b��"��l�Y��7�z��$Y]�<��JC����YF�<ˉ��;�l��>#(���(�C<w�޾ڒ�N�t�)d�^H�'=���P�~D����g��������I]�#��Ko��Ś�����ߤNYG��ԍہH�iDoA�������Z���!���Ԓ�ԪjƱ	�A�ē@�M��CwN�a>�58���F\�a���ن �Ժ��_?�bP��Pw]���؀�.�y��T]��j�ȠK��]F��,A�F����4���m}$�΂� �{�����\�<��\az�9�B�g6z�6��Z����w��QH�#�����T}��k����A��#ţ�����d��4pv#Ez{�$ý��ߌ�����T'(fEQA�J��1V�*����di	��1ڎ>/c T&�F��׬�W*�5�*%3�*�՗+mU�}V���}�@d������Æ�S�5�h�
�++��ғ��a���(o�Ax,��WtԗEh�s�\w-ڢ�Tq	Auu"}X�ړ�~�d���)�-x@Q�[�8��I����w�p^��^�:�%)��<a.Z>ԫ�ϟ'�����>��� _mr/}����eǀyJd: &k{�p5_�(���ZR\�y�����e$S�a���V������9�d��b5�r�WCܐ�5t����*GE��f�����bÆ8��w���"eVS����N���Ku�j�[g���d����d�-�rS}��Ab�ؑs�d��s�5e�O�������ؐ��T/4�o����Μs��+�hݻ�L�We��*\D�8ꡆ���1�~ �p"�OnP�3~t����'��PӇ�5@L���4��,υ��
f��C��_/�����	�%C�"��� �B���M+�'�гwؒ	�-`��v�iL�D咻�}�")��s�#�_��*Ғ��Y��%�N1�6��u�Q��ǀ&G�\}�P�8w+n��p�e앜#�~`k��1����*����i�Bd�V8�/J���g��+M~< yiJ�􈆌��h��J�JO%>Rlǎ
�8�6"f��Ds'��E���CS
�����
2fX���!�qd<.��;�\!a�\�ܑuc6��v`�)�Zn����Ӛ>|�	ٕ����B��'�P��$O�M|��%��.NM'^�z�$���)���E|.��K���e/�pfЗB�G�^� S����/+���㔛��Z���eG��V���/L����A�����@Pc�i�,+����<Rױ�ȓo�NX���5�Ԑ�5u�P��P$�S���.q�)��Mv��+ڻK�%��.�k�3B�q �$㈖��bȁ	R�,
�^չ����cw>c�      �      