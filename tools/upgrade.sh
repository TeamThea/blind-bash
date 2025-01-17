#!/data/data/com.termux/files/usr/bin/bash
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
skip=77
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
]   �������� �BF`�*�+��)��l
�!=�N�T/ԡ�Zi��f�۴�Y�]ظ��V�8}&�g�B��'������7T A|�޵W�gs�k�TE%��5�6+B��w�Q�A>�L�Ơ\h�4q����|���hܾM��Lg�j~[n�>t�s�׹�8/빓LC>)yyI��l�&o�CD�i��$�����p��ʻ�����"ki~��jw�H��#�ܜ�J�Ҫ�6�5EL��͕P*{��rn9+��)`rQ,����`R����>�j-��u������m�������ӂA+�=Z���FM�f�=���:c����1�]����DD��N��.��g}b0��_���:d#9��ד�ZaL����E��m��mwdA& �-f�����X�E!g\*���9mE2)݀5y���_#p�7��P+m�J�'$�Er|���  �ʙ鼋����t�TL5�x�Kor�kC�}�bZ^Z�<=�3���3����j�q3
��$~��M �ʲB�t2J%��6ael��A|�R�C����>�e�*�{��g"͑3tH�}��k�/uۉ�l ���ѿ��Az����s���� Cb��A)����Q��nb&�~�8ǌ|Y]*�� ��K*вCTTU��bO[�+ ��y������~��v*֗ �L~k�Aـc�w?�R#���T'�W,}T<���D[_p�~w��ST�B��'��==_奠s��+"G/�\�����t�/�o����F�"��\��-7<,�`�a��������KL�4����8N�ʉ�J�8,�����/���=�xi4�r�H�ƑGI=&�2����USwU�X+}E�L�z7���-M�0e7V�5�i��-���.c�c�\���(��f|�%�2�F�c})}~5�6_�'V�w6̇�"k/���F3�.��+�s��COo�*����c��Z	d���c��1#���s��T�,M��a�8��ƺ��zٟ�>�K��2ގ:����IىT۹߽�W!y�y�C�2�)�A{�{5��/m��׻�q�߫ء���5ݭmM�Q���E�����;�gѣ	�L��Q1_/�6��<�&<�ܜ��O��Y�)N�Nn�/���?�Q\��;O����?&�3{p^YX��o���E����q��D��(�+�� "���qvݷ����"���zow|A?�K��e�Ǫd?]$b26Ⱪ=?~��8.M��R(Bcm�1�`��Xz�G^�o�pC�bU��)�����P��6ѐ�h� �&-�/�����	�8��
���t�j�`���z�SzeI����Ҝ�*�^�0-�&�<��U���FQ݉�����3���U�������f�:����G�tj���C_~!<�"����4���K�
��.�PL�ӫƈ[�Vj�N�)�Гf��,��3��6{/E�V\��-�����U�zlc�CM����T����F��c�ʪ��KcX%�	x�9hf&��|�BM�-�,zk���~�m3<P�ߞf������:%`}9+с%�E�����g��^U�fU����u�|^oK������Qn�^��c�P�2��͌^���^�W��;��q<j��%c���H�pˣC�Zz�l!";��I^u�ZYZ���p���cx9T ���򵩦}�0T4������ʖ_�0 �}&m�������HN��;�;g�\�N��<'���T��%c����b.ĊȲZ��<nx��p<%7T�@�� �4�ۀ��	��p�7�,�ؘ�g�͑��Æ��?���i���g
����.�::��f0O�P��^`�:*H���Zv	_��}c#$�l�Z4*��PaD���ߘ@�YX����E��X3`���yv�?<��+J\L��lǺ>X�CS����<�/��vJ9@j?�+��*�!�(�h�N)k,���gf�����|.��'���OpI���G)�b���=,������b�F6WKnɨ�����+�K�<T�X�w[֙�HKQ`R��yogf����B�/�(�U{D��%�B�k�����a�_>��t�Rv?19���<͎��,�l�y�_ۄ����6���� crYcT�ݎ����z?���fC�S�~M$] �m��<�Ix�T��Y�lG��g�8�n;�V�n��篯�
;����y����ЁJћVҩ��bl p�O��7���R��lJa������}����K�������d��#�l��頃kQ����5�������T�]�G��ޟLjH��Ƃ�g���(:�,�6��dL�@0�+�U��/�J�1_(���_U����C�>=��i�)��V說K���y���g��bL$bF�aP��Φ`��!I�VckR6�Gv#2ew��(}L
ǻ`;H��Դ�H��`���"�Z�gϲ�>yۋE���r���������j�y�#s�p�]�����)��o�O�/54L�SӃ�r��o5I^W�F�]s��q��b%��]�·�؞&F���,/��l�j����!V����k�q��b��b�B|���y���fECyH���~a�U���f��s/��p�8��!����d3}�����t�a����'�?;7�U�Wl[Uw�i�ͣ����Rb`������ _�����C���z�%(�+&g��j�>�N�Au�]��.Ke�K�����;���[D�'�nӮQ�3Z���\�}���E�f|n�a�(��,tit9���ɥD9{:�}ü�5b��VC/{i����E�}.������?EC��.:�a��~j������~@��$���It2[�o13��o~\���O=�[Hs��ep*�.��na��>��<s�$K�>����������������� ��J�JUh�%��dۄCj�+a��0��Ga�ލ�*��U����!ղF��N7x^KqO� �[-�i���m8��<� e�Xv#"_�&(_Ԅ�pB�>~�\ȥ��+<Po���' N�2]G�f>>~l8d��IB~�gF��;V2b΋@�����*;�6�թr;�{ϰEKѰ�[ ���B��T\����k	�f�#�/§�+�
%^Ѵ1py�@�i!�L��$3�ng�w�$0"�"\Sq����Q�����^k�	�.�8��74���{���'(m�."���7����7`3���̐b<�]�
�צL�,����bl:�E�oս��P6��0�LQ�����}c�K��b����S�#-Ӭ���sf���m��,��p��;�k��(0�_����	c�YH�2����>���O���(�Z������S�������O�\sm�h�br
!����s�r��^��7� EQ�`$���XΕ�v#���#J�1�^�
�!�5�Zl���L����䦚���Bbu��"E�e��8�aM�ܐ�O������
F�8��cO�Xl�7�G1��~�;��!�V�Fx�L���[�r�x7���^�A�G���e�3r����G9�9q���mBİ*��b���D�1W�"�G��:�?L"��dP��M0tZ�T�U'�+�&7n21�:b�_�&�Pm}�t����$�5�O�Ef�i�c��n��}���[K�C�4 �3��Z���"��[�xFU8~�U�|����������"��%[O�3�����pPB���i������B�pE���Aa��������h�ʂB�'�$я� �j�{;H��U�3�eG�!E/�Pr������>g��s�<޸ay���{�@Z�cL��~��Rn���׌�	j���=30Yb�`�!=����� ��zҖ����������C6^�ӀiG�|c{�C��R4_;ww�@n� �2����z-G\öA��s�T	p׺M���!���!��mC�H��tU��'[%�o#��%�\b��G5�@���47V�����ӯ�`f=������G_Ƅ�4U[���i5P;��#
�A��ɯ�K^&��4�{`=?�nT �%�π[��FK#�����
�b�!��w�������.���'ȟr0�)��C��o�	��-I,y8n�����H3��|[�M������/���D�)'nr����"�4҉WG�^�p��=	��@� <D�s��X��3=`�ۉ�N~�� �Awv�/��j��HIoɱD���@х�䇭 �o<V=#"������ՂG%�WP�cQ��V_�9����p��+bc�<���rDsug�m}�C���tIe�Q�a��%���#&4�����ZB���m�p�\�$\=GHσO��Yg��@y�-Hs.Բ�^M3EM�>��D�8���i�[�B�����[��[B���ЊR��Z��~|^M�E6n����{0ā�/~�[4�s��x7N���k���h��_�|�-�²L1�i��Md*�si����B������І�o"u'#Ke������ق�j�S�/�w:Z����E�/�l>�T�	7qŭH<�Y�����;�2���cډ�����j
������$����l��[���J?+,�k��l6� 