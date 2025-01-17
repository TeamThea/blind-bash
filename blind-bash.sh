#!/bin/bash
# blind-bash: tools for obfuscated bash script
# Probably not compitable with some device.
#
# Copyright (C) 2022-present Rangga Fajar Oktariansyah and Contributors
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
]   �������� �BF=�j�g�z���HȓMl�( -µYd�d\�����|f�:��n�b42���,�)�G�Lp��d�.+���*��E+��B�X���E�i�7S��HO����2R��%�X��MXt���%4y���K���Ȫc
���{�{���������k�~Bc����^���:m�Q��9��ЌC��-�}Ƒ �V.A����o���TRS 	�����M�T�0K�}���d7�BU�J�Z�3!��B|�*�K|[z���a�:h����X'$�%d��΃��ǌ���՜�վ�ˉj�}�۫:vTF�� I��7kj��(��x�P^,������z���put
�v&7Z�I�S�ɴ.��M'嶗7��t�Uc��G`����<PXb�I�\��҄�~G"S���x�&���Sh�*&����o���}�fk�d��(i �o����.k�bx�.��W��-8vc����H9�5���M]�����U�&���Ӝ�`���C��dd��(�2�@u�ٰ&&���"j��d���C1�bI5'���Q�I&�5�����C�K�]�Ӝ�FCP��cc٨IK�!�T�ӎ���v�O�a�ґ=����%�V&��x5��<�w�%��bm���_���+�=RNDM�CE�Lu��D���?y^�����\�w���ӳۧ�M$݆���6���,]��͏8��$D*49끯����;V��u�ՍےߧiA\V�Np3�[�6�A�;M�����h�';�ڞ�ט�yOL�D��҈HR}������1��nΖ��}��W�S�/UaVRS��T�@�o:V�����5���ȅ��c�m�%���=n���Ha`�K%�%�d�	���m9�j�Q|����^��s��-��jV���#��Md�_��Ƨ4����(����N�M�� {c���V+�"���p��*r|gS�	8��^@A7C���DQ�A���!�-���	ԣ�$�D��\����Tw�(S~�f<�l��'V�V�S$�!�V�|؍�83>��޺��O��q Lo��|$�� ����Dp�����Z$Ơ.�Z��T1�p��-G���\?�,G�x��>���w��8�k������Ey�
��o�M4ۢ@������V&��,�A�AN�#S*� "��;O�$?d�����[K�V��2��O�}�9�cqzM����V�����X�uot�N;�|��A�_���c� G!��^�P7NS��-E޿,�̱W�L���@#��N곽ڒy��Is^���f$rZ�hJ�}vO���K�!0�'����<c����c+�*��ǻ>��#��杫4�S�������D3A��X+��!o�d�_�y�ի����
+5  �?fܚ�n�V0�$��_e���P��x������U1O�����t#$�^g,i�� �����2��@�"��L0����r�?qh��h��[ �רE�8|�Ζ�h��&�	]�y������������u�~�iq�"���5��l�D�����~`��#����\��Dب�jwD�-���j'�$����1���ju9u��u���� 	2[R������4*H�a+�s��r��an-�wM#徱r��`� � �c1�����ed~�m-��B��U$ ��vj����mW\�>�0����Ǥ`���r�I�N4־�8�����mGG>���m+���\}�"����@?j�����z�Q���Q3��q�F}��T}`��{�]�,���.E%h�_�2�v?	�{$O�;q����݇/��U�*�Z>�Y��%#�4f��k.]����� �K��`le��
����4�,��s=9d)��B/����Jz�ǝ*x��~��!|�^E���q �&h�_=�XI�	��.�:�9��'Y�;K���\��Y ��z|�~Z��Q��o�/Z��l�	���f�#�5�%1������;��6}�7*ao�@咢ɂ,�p����.Xx�����
����!{�`{�_��}"
H���� ���N��|]��Z�������	�	�&wѰX�����VV�G����SNm�? �[y��Q��58���W��7�*��H{���}!l��֑�*��B��70q5궳.�'{�2�vJ�]�t�"��=#��E\nГ�|@^[ $Ez��L.tI*ʰ�{�����S�XPX<?�o���F�2��}^,ͳ<)Az�S߭����4�2�z˼Ĭ�C�`���c��9�V~X�0��6Sah�C�)(ZՂ�w�q��	Ā�9�{�FʂΘ|��0��2]q�a���.x%�yϏ�!]�x�Gx��Ŵ���c6�U���r�휇O�C3��x>���>�KC�����b�P�3�_}g\��|�0���V{��5���2T�I��;!_׽��a?�QxG��kn�����ð��ɲ%�T�n�+�-9��U�5	,U�(�r('1/�k� �գ���]#1�Z��h(�4��&RnG����&
�a~����<j/�W0��=}�u��aO��ӑw���W��Yu�%1��B��F �bL�>G������ʵ�{��ғ�*1tY��yu�^���ԂAMЌ��7g2���M$^�Rѽ�6��)��y�L������c�ɰ$t�B]����?����y1Z�d"��^�ȂH&|#m�Q�^�&��q� iz��W8��{�w�N�o���!�٣M��5�ͩj�yY���U�%�Jt�۬��#$F&�b��d�|d���;-���Q$��@���/����J!u៤3�x�o;B������_�GKw	{8���ҿ���hrH4Kd�y����]"�1�6��R�#�<6h��"n�H~�<�%
̎i5�
��4jZ�%��y�y�V)y���(B_|O�ܚ�~:d��W�{�n����@�"!4_	����.��}���.�=�v3L�B���[3ay6@�����c��I����^먔]e��:t�sǥ.,��1-��y��H�X�K;\F���1Ʌ�8&��i9�Z�Q��Z�����L+�"��|Dt)�% Π�;��\��=\������x<%�>��M�)��Y��:-�����\���R@�(jY=8>X��$)���)F҅��㓷ow��B�|�g"�,�Da�@��e}qw��!x�4�Ž|�w�����w	1;�[fO��g�7cj
�Gao��mr�GԖ�H���T��}�Q�/�{f�^����f��F7��4$�����7���ٓ�*E�]异6ݼ���-Ur�B����(�$�V�x?���Ui_�#�~��A�x~�\��D/���R������;w)�9!��w���!�d��)�c�y/G�z�C�
�XG6Dj�����7g}O(�zօ�d�T�!��|�@o��.aTʮ4��dh�!��3藄��[�9���k�<���WD�ϛ���壟a5��H���s-�H	�)+(�r�sd}i^��>-gʩ��X�Q���"�:Ա0�[���������]D��gEKZ-7�'|�sf�a��۞�{Qbk�.�T�2<��Cd��T����� ����3���2W��e(���#Љ�LD�y��V|V����=�m�q1b|�T�1o�*�O3_�
�e+���4���b��T�tk��rXj^ʎ�����[��HG�V9���>��t����	|Mʡ�=[�DI�6y�ּYwb�F�:��Ǜ��k���|W�Ss�򠅁���!����,�d�G$ɗք�'�B Kz����$�d�#h�M;�� ��쩍�ƫ�|�o��ZB0�Mx8B>����Tx�*��s�G#����BTp���R���g:*�أ�V��iq۰��D5Dwܸ!������lX;9?�w����Xw�7
�x�"����
x%<sW �s�0q����]�"Qt�F��]ȉ[VY��� -�p�
����8SL4qV��=ML7��ډus�,�"f�)P~��j��Dn���|O5��jK�qhL2O���z�l�1����'T�,�{�8@�.�|�"����U�Y��cM��v�ʑX�N�u9ˡ�|��4ʰvTP��е�Q(��]�{*��R����5פ|I<��SG�Jx���ߥK��U�>_�6ywZ2@~� �4	N��ӟ��s���>sxU���� �𢑗��c�pm]�	#�g�	2��$�6�l�A���xk�a�Bcs�|~��;S!�E��0.�=
��D�7rC�@�`l��& �Mq~�C�T�{u����r^r�xS4��똨/���?z�]�i��͌�^����&�X4i��ݪ:$Kg苛?������<̞��c���!�&��b���{`K�^�u8�E�Coσ��&B��� tW��}~)ct*����,�~-{���n�P�qPU'a�@�^(�=�'O�.�2�9KN�P��4:$+�뿴@��r�Uf�d-6i���Zɗ	Ȉ]�BZpï�뙛��'FV}��<җݼK*���p��ˡ��A��.��#��t)+�SC�A�qb�����u
4RD!A�^#�����nn��R>:u!X],�6�f}�_�T��mǈ��Om�r�H_��28�ݝ�X|΀�Bc��s���Α��\#������ p��_��5[Fy�u�>��`�����d�u����=c��Mgm1�~c[!�EH�X\���u C���ӹ݆6��]�M��5vK[B���T_��u�P��&ylY�I�uC�`�^��^��L쒀eR����b��Ԣ��@b�@��������<U�	��E�I�ᒎ.����K��}T�}��ٹ`�_/|Fqxn$���c�\-Ӏ�n��u��|vG�Ƅd��B�Q]��L�dxd�~�+�,��(2X�/�ՎP��d�����^G�jv��� �y�o���P�b�=��_�H�X�����[0J�(�}�dQ��M�.}c����О���'��̸]�����^d�W�;Њ�������q�6��]
���m׷�.Ӆ�E7��';I�T�֊hkE�,U8@��5ߊ�S)f;f��΄���Qm,� ��쩈��K��˵_�`c�-i�q�*�soR�����ֳN�����S�"�$A7��<���lu!{|�y��zM=2N�e�-M~�ja���I�;����-�\���F*����Ș�V�`L}�#v�\��(M�(��y��[�>���i�~��l��Q�ӹ�M��x:��5$n]�v0c}|�t�e��Mx�.���Zt4�;}ѩ�X:�)�?��ȿyp� �Ԯf`��P��*�������R-��K"mX��y��F�}��9Ɍ�?��Z�D��5��M��dE��ͱ��j�f:�EoP���_��,�5���V�B�ԙn��ӆ�G�P��|�|���o:��tQx�j�+��Ў�d�'���P�Z+�p�VAe�w�Y��Q�. ):kx
�E��ǈ�L�P�j5J.5^�uKO>���Ț�&QЧ@t��S>{��RPF.*ḵP�G? �|pI 0Vp�!t�8�s����
כ,3�_��P����F�驹õ�sK\[Z��#���&�������"��"�md�+Ҷd{DS��s*��'����~�1t�E��<W�Un0��j���m�\���jqN~�J��_V�{�*;)�I%��%\
����Y�6ߓA���ȣ5�ǩ��Ƭ/�2�Z��M����������-�͝���ڲi�.+���?�� M$>�'�KG�R�>�3�՘~�y����8k�Wh*�e��^����G4�Bt�K����Ln8�u���Vo.Ou�6��-/;W��H�t�;
��-
pG��F4@��/���zb�|s����t$�`�ߤ!��I+�:<�e����!��)�z��sC��r���%����y�q�;NAC�[:''��TK�)�(�Нu�׼���[��3dM��2ױw��mC-�C&�|84L��!�?�)�.�FW 5��g?ծ!�$O�lܒ2��P�TLR�7B�Od��L�U.D������c�E	�
�]o`ߡ�O�Y{o�P�M������K���SX��$
q�E��驨�`\-w�!��� ����� T�%f�'1�g��]ޘ��y�����:݅���t�	f��N���h	�0�,2*Uβ��;�#}�Gs���Xrj�>Y k>@ ʓZrctM�6��d�����%-i>��~�$SV3���{���2~�@�[t�u5윉s���8k`>x�	���{'�$�`���W�C��Oӄ��M&=���#�%�X�'&b^H�X^9��� ��!/�g�h!۱0&�
���a�Y��� ׬����j��/��əfEm;��oXٸ�{z%����K�є��B˚g��w�:t����-0A��~��(W�N����?�XE�����`D��f9��q�h����8#_-C�H�QK�eH��wf�Ϥ�P.� N
���r��;/F�xM U��j���w���m	��´p��lќY0�eVL��8bmq��AہcO?kk���Zܵ�R�ykW�����k��[\<�_����fg��T*w���5�=��E�5Ґs�񅀼 ��B�~<��Gφ��Bx����,,��|�~z��@�#@�;��(k�պ� 