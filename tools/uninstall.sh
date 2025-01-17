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
����.�::��f0O�P��^`�:*H���Zv	_��}c#$�l�Z4*��PaD���ߘ@�YX����E��X3`���yv�?<��+J\L��lǺ>X�CS����<�/����tjʪPM��/OWO7��U'�	�(�a��z�#ށ*cq�c}5�M5�͍���'��8)R 2�W�Y�>��堪ˍ<��a��s�A�f��]s��qK��K�]��D`Ԋ���c@���Y�DQ��ⱍm����.�$�oC�1��k<���-��GD�f�pnr/?�-��٧�����EB5��eJ��Vc�<(?�_��S�d��D��N��}gQ>��Zv�7�kzL�Qia�ێD.��8��������*�Y?����O���{�`0��R�66 �Z�-jطM��G>9]dѻ�K�b�Qj�W��hT��#8h��ې&[``7S�A�����7