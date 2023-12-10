#!/bin/bash
# blind-bash: tools for obfuscated bash script
# Probably not compitable with some device.
#
# Copyright (C) 2022-2023 Rangga Fajar Oktariansyah and Contributors
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not write to the Rangga Fajar Oktariansyah, see <https://www.gnu.org/licenses/>.
#
skip=79
set -e

tab='	'
nl='
'
IFS=" $tab$nl"

# Make sure important variables exist if not already defined
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"
umask=`umask`
umask 77

lztmpdir=
trap 'res=$?
  test -n "$lztmpdir" && rm -fr "$lztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | */tmp/) test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  */tmp) TMPDIR=$TMPDIR/; test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  *:* | *) TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
esac
if type mktemp >/dev/null 2>&1; then
  lztmpdir=`mktemp -d "${TMPDIR}lztmpXXXXXXXXX"`
else
  lztmpdir=${TMPDIR}lztmp$$; mkdir $lztmpdir
fi || { (exit 127); exit 127; }

lztmp=$lztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$lztmp" && rm -r "$lztmp";;
*/*) lztmp=$lztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | lzma -cd > "$lztmp"; then
  umask $umask
  chmod 700 "$lztmp"
  (sleep 5; rm -fr "$lztmpdir") 2>/dev/null &
  "$lztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress ${0##*/}"
  printf >&2 '%s\n' "Report bugs to <fajarrkim@gmail.com>."
  (exit 127); res=127
fi; exit $res
]   �������� �BF=�j�g�z���HȓMl�( -µYd�d\�����|f�:��n�b42���,�)�G�Lp��d�.+���*��E+��B�X���E�i�7S��HO����2R�KC��N�|c���|䐺���Rf����5?���٣��^����Ѧ� ٱ����ͩ�T4Y7�׀`T�>��R�	�\����˓�5�l���1SI9�:�Z`�7~�x���!���n�t�㽣RaQN�=��^�ᖚ��yݟ �0n���"�I�/�����f.Q;�C8mE�`�3�;P��(/��1���U�L�2p�]�1�qK��:��CI=k.L�����%��5�������y{5��#&[�"9P{�j����㒝r.C�r?D��܇��p�?�HdQ����]ᅃ{���*��]�����@���t��������l9�0��=�#[^���&�i�+M9�3�W߳?t�Dd[fu>e�w8���˴�ʃx���Ȧ�:�ж}��Ƽ��?� 2�����R	�]�o0�x`�&�!��y��y�B�|v�|S@V��������� 2K�������p]w]\�i��?��V����e����]CʛW(1�1E��o��]������],m0�l�A�n����������7@h\�R�2sg��%%Ӥ���=(QDB�����prP��68�sf�;��fol_=�_\��}%�:�XLs�O���u�G�e����9;|�	��i�J�������	�<&3���r�.K��~O�)���(:]��]<�����Lɺ㕾F%X�K��I��c#�&*9����R�N�����U+
�C�4�%t ������iu<�y_��ZAA��c��h�n?���C�����@��d]����@�5<B�5CX�_ia.eݹ�`�3�&e�ha�'��
U=t���|���]���`�I?A� BTf�F�L���Ј=�;�t�4��ݐ�2�7Df�M� ��<��.��@��y��6��2�1k���[�K�������� ���\-���(���\,b}0���&0lq��i�����ٜ�M�.ꍰ��ɝ��7g̓-?���?0UC�S���`��jT])od���6@�mكH�BZ	�=o�$��^+s��� (�?���� ��d~H�*s����}O^m)�8E�YI\��4e�"~����-�b?��0K<kjdZ����P���M���B��Ա4q��pzj�T����ḱ�$�BK�)�}6���ށ�FF�y���e�#���(���e�������3���Z�T�Q��.x������ ��yH5�,�o����h!�F��1��~'d��������}���#�O����^d`ijLOY�+of��/�a�,������&����)�h�
���7�;�U'�$�QzC��k�t�$e����I�E¿+�.Q~�Ixp>N]	�q�&�����lځM�� �>��%CDe_�����w�Îq����nsM��6Tod~o��_pxC���I�Z�ͻ�7�~�B��+`-�EY���=>��)���j!��j,=����R^9�㴺��Ǟ��L�?�9�� ��42z4;��cǹ{�d� ��
���|�@!x������@��K�h���
s�vH�7�Ŷ�Զ��.�O��Q�%�}�/X�!�>�Hcw5o ^S	�S�u��#�h 'tfH}�^�/�/W0e��s{|��Ii���|��q��8/Wq�.��t�ή���L���U�E���U����G(q�J�
�gSr@D�gw�,z5ނ3}.��U����v�Ǉ��e�Ɓ�w�' \�B�Ԋ��&�����),�ؐu��%f����>J[�ً�ږ�?�l��}�$u�}�Z^�����Dup��_|xp��yu�W�d�������+�<h5Ԝ���ʊ�Eݟ.XIo`�nVoAcƙ���i��֌�a�6ug�L�X���|��D�v�������Wv�쨒v��!�VR��^�Չ�*��mD����z�&���NL�'�GQ��z2���y:C���m���7}�2�c��H���ɇ:����/� ���1���(�,���/�{g���=�,v׸�佃�^~ۤ��Z�Q.��!^"N���َ�[ɣ�<�0�2���c���$��r�#�A�U���8~�R�%?�P@��1��4���������;�"Q3�l/��W*)I4�a�wy>C=o��D��d".��;p�Ap�kK���~6Fy/��'4���"d_NtO�5�C6Kݲ��0��}�A���"�3���;g�s�g|m�_����4���T\��D�v�7;|��dZ_�ɕ��XP�v�f��֝Ҥ0Lk9`��� ��S�EJ�y�U�Íռ�S�³�m��[�����tHd~�0oj�p�����g�7$��ź��@�ƋV��]��CvE��P5���OR��;�U�A^���[k��,m<��K	I&�PR|3��,���N���3���;sA��~�<�ћ��_\�.��"��{t���������'^���N} =���D�y�&b!��ۼ��jSk&�8��w7=����clA� ��D�|��o���{^�"q�W$�L�MQǯl��'�r㑼���<��D�pP ����c_M��Nu����B��%5�_"�̔���1[=�5ꐜ˳V,��5���o���v!:\�c�\y9���d+��k5a<���cO|TK�3|_�q��C]RiR�.�/��AOfB�3^�z�ǝ��}���x{�Y?�n��P����ƃ�ĸM@/K϶�+1خ0�����X�W�ec6m�q���.�D?�Fp�f.[�N�,&��}2v߀��`�ZЅȆ��j���#Oj�W�����v=q��M���x���ChpHP��e�4I�:��?�:�H+`v�c{K�����ei2�`�0ӎ����5�Ȧg�F�*��sHE���D�y��� ~�a��C��An������c����\�ZcyQ��x̽��jo"
d��=1��֮��6�n�4p�%J�� mCJ�4n�[���j9�lz��CnwD"(�by�� T�?����\�i��e��uR��kQ���C�c�f�ӂ��r:���"=	W�Di@�:m�~:o8)�R+��!j����=�Bp�p�SK6����e �rz�x�K�'��JkC��~�<�P7!���_o�2ί�j�H�6D|����Pe��!9ڕ-C/5�Ųo#'�et��kF� �7alWav������ӭ��/��-���\G�WAa/X;%H4"Ű}�_M?O�ş3��e���tk��:ޠ��H0vY�6��$��G7`��e�9�NbVy�շvB!�4���JM�����G���M��,�9�կ�����`]xҦ�f��Vqz'�cRxw�/[t3[F��9g q�9��#���F�[��gv �i�|����Ӎ�o�Ҭj��db���1����{�������a0����  ��4��5��'J_�i��v��.�VHna���h�����?8��
e;�8Ť�����ݫ��HuQ^\d�"�u�#à�#�7�T�n�>U�?z������z����.�Ů}��e��y�c;)f|$�8��U��Մ�)��H�,ʏV�^�(j�N��8rd�Y.�	>��E���hJ���������ͽ�	��%IK�V���@4��g|�X�4�
`2d�K�(��7�ZV�$z���mA�&�������V5,��t� ���(�'P��R:����\<�Tޙ�m �#�5Œ��B8��1�bw����9���J�/^���u�} gΧ���ZT��L��V�Q;��i(��BfWX��Y�\�܆�QŃ�C8`���6/&P�9��6re����E������C�z�s�ٔ�$
�� ��E�\f.�j��j��5���웷{�����nn�<��PR� ��(��}8'޼PA�$V�A�Y�S���N��y���@�[3r��D�B
5/3� -瑵������"�֛�y��͚U��=��	����Jc��}�H�pvAz/��ݙ�n���^ӕ��� F�����{{tk��)5Z���$�����Vm:/�&�a��w	74���06�5ă&���c�e�a*ߤ3f����{�C.uF^�p.�R�=&?�=W��f��HP%U�g��oo��k����Z�IEP}"� �W�#_�:l4�������<_�T����Ύ��Sa�ـX�WuR=�{m�����H!�z�W�^¦��& �QVjo+�W�ZA��;����b_:��G�HE�D،�LE!�J�	(y���a��{�}Ee?�z��y����_O�����[�.�e�1266��+�޿'"ۀ4���]jV��u3Is�'�bny(�e���R2���(]r�'Q�VL�u�����R�*$�K�M�/RBϢ�.�3���9-�ߵU��
�h2B�(Ȅ3��@�i2�6&��Adv�h�v_N@���!L�Re���!`�5h=w�k�e_��n-��j|��$���#��,������Ȱeq�SJ���X����m�V�9roX�	*9~6�E�Qj��ߢ���A(x�"�(��`��ea�����7��+��������� ��R`S�#������l�^�B<�q��Ik`\-�b����֢�U��;�{��b2l�#�e��]��&m5|�Ҝzs�<X��P��� ���u٤�h�}�������ۦ`��>"���PE��T�.�?�=�N�z~���o����zTE��������K>#�6��.5��2-���Ab��Y�?�g�����x���՝�����Щ����Q���>����������[R�`�w�D��לvX�$�$uF���0�A��XKV`h�2`���n@���L��^(�Ry;Nb������GX�Vu��1[g<���A��C���t������DF��%��w�5���@�Tޮ��i}�F���2��#�"�����|�������Q���c�8#��?�DŌŶ\ٕ����ׄf��/���@p�s{���xe��wz�9�/�ok�֫q�KP�@.�|�֟HF/d�TM5�UpW��u܇<�{��^6�1�����v#��{~7�l�0"�\��)�pK*�[�m6�@t�1[+�2��,l'��*0����*��Wۼ�枡����
#�>>sa�GsD�B�瓌�Z [5�$wOŒ��߫~E0\mÒ�����V��*�F�U���h
)R�~��瀩��x�%}S���h.슏)�K��/��8��!�8@c��D"�ϳ{!�C�{��"	��*N�7�s�,rgn(@��It(}8ܺ�Ma�*���'=�3ej�4r�)ý^��f�
�(���N�f',��gk��L˨��k�]6c��g�Y�����f3�o�os���~m����>5oXl`_�ޣ\�p&�pHۤ�25�	��= =fx��]N^��S?��q0
���#�Y�8�<Q 5#�]-�4�����߉�t�s9���NC��˴Y�tR�aݲ_�f�\�tc{{���j;(pg�gju϶����"@߁D��)!�Zg����X,��'BV�T�f��qD����y�M���.�&�F�j���ۓޕ���Pze�p��Bd��#��˳v��W
ƣW�$a4���?j{��B�v�.�e�6q'o�jw���vcf��o+�y�����A��5����c}���6`�γ1S6n��M��K��0�H�&N�]��h�h��<Y��,/�t�]��e�/)I#��� Q�	o��z��� g�ǢH�巵�h�3�*�:�l��|47�3۬��^��������E1��w-_�`�gjt$�S��Gg
�0@(���)�0�wR��+Ү����K)
��S�@]�X�*ڙHm��C��,����^b���?~]� �W����6)$�ȓ��@w�
j �g6L^� /�L!i��;��;�<�V/�B�����5�+:�$��oU���,IzR;JKc�<�Xo���s��E;$ ��)r�a�	�؆%�)��.�-�7�����|����[���ʜ�|���*<����*�����+kx=�0�pH��WAy8��mR��n�����������x����Eq7�.ǩ-��A��_Uiq�:�QYb�P��s0O���U��%贪Z���,�UNDK$ϯ�q�-�c�+�`2��c� $�Q%��T�0������Fl,�(��?�#������������@�M_��=�~�M�P�&���@ه��Ob�o�������b���.>�݃��&��|F��s�.�����P<��b!��hڄ��ű��~�
��I���ܼ��M%�>rՑ�`}��� ������a��+�!���''M�@�/;40㝨Y�t�&϶�[e�v�އ�x��Z;������wp�<��~/8.��'�oA�&B��Q��-�/�ƌ|�:m'�!N�tu˳)�Yt�)b!������~��$$�DDY��X$��ӕ���k�a�o���gP&��"�*�8�ɢ�= �B<DkE�:���'�ײ`P��<�:����hݺ1*V�%���Q2^+ʶ����