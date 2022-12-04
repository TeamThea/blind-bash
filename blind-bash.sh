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
LZIPm �BF=�j�g�z�I���,;eb����YqC�gtJ��8�<d�����Gq���	c9ΦB�4z�ߵ��[�T9N`�xf��G��;[�T�@�d6�>Ec^gs���� ��*��Ή>�J��h��	�6��'e�8����;��&��l�#3R�x��<�^�>S9�":dQ_ɝud�:WeC�ذVt���GF����x�B�uX~f]����s.=P���m��T�GƗ:5'q�[۴AZe�#����w��@>;���p@$���J��Σ��=���&�Z�Z�w���oR�'��6�0?$�`��B3f�'}�]��^7|E�HUu?��;�/i��y�|s&dD��2^��?=,%�'#(��x�4�v?E�� .�so�e��&v�*��=|���b6��%��u�mZ�����G��R(E��
/Eh�,8e�ɧ�}��e>�F�A�&b
���4o���D�L�WC�\��`-�;�B��_;!1QV��=��W$�dX�,]��g��2]}�V��e�G=C���Lb�iB";�L(|E��)Sy�ش����G�-$��0���Ř'�2�]ͭ�os��D�鷫�F�"��y8���F��R�L����}VlR�Q�S;�O'k�aS ��8Bjp�W�<1û�J��#]�c���q<��D
�C �W-{*w ��'������Ȓ$�.R����������ܒ<�7Bz�8�2X-�<���q2h˃�oЛ �]����]g��������!�/u��vO�iG����$HL���K��!� D>|�'='dp�{�����i���s�@!����X��Obg{!>�"A�|n��*@7F*h�bH�EIi��8���\~�n�	H{�ya(�l}w���Ԭ�Vָ�'��/2�C��٤���<ע�>����j�Ή�4�&��"ݏ��αZ���*��އ�%=#�F/6Q��d�k:�f>�������0:_'���tV��&6���Nk�zd9"ί�}4N����Q��j��u�-q4[���U�������[ܡ1~�� �����#��w�Y��l2�;�ʬrȇ�|��C��0E�`�]lX��c��ѝF����Fm��dl2��U�X[xd$�ć9���^W�t �F����ގ>T��?t������q&)��O�ַ�Gց�.`��bu���k,ۗj��ָ<�ٮw7V]��Vo�O�ݒdD�#�bFyH�jKpAo��?�%��d�u��~4C�Z���AwY��,��מ�լ� V?Ct~���u�R�Jo?H�7���KZPL;���p���� �4��B���/L��vl�	g����/~6,�^V�id=���S����Z��CW�����p#Ė�lm��f����LF��3}Ȇ�Z�'	@�����ÕhO�^/	�>,¢�~�t�uv��mΓ{�KwȞ�e��.��啐_!%��e��۝!��C�b��������0U&-js�̋9i�0��`)�r��s(ϩ���*.�ƀ�.Ta�ؼ��^���H.@C�t�{��`��i���,�=�O����<o)��G�o*�"��n�_��ae,>>A�.]#c��q���|Ε�������O޸�f�nsc�Q�[e�~��\�m� �;K"�e��a����zs��7u���ο|1^�%�|��O��ɔ�V.�$��@Ғi����ye$^�ˋٸ�(5�u�̈��}���j�^c-�u�f��.$x���; ��x�2Z���P+vhܖY@�̋d@b��Vv���q�G<����l��5HE9����#/�e���/���v6�h'�_�Q���O����p�L%BkP~�i���"�R���eq7F#aT1�1�5a�~���nr.֮�	;�Da��R�⇀z�_~E).`&I���;���߯�n
,��� *��WСɯ���G;������AT>z+��N������JJ3�ϟ�,ϮS�p��1Ǭ�,�NR�9?�j�C:^������d����^�1�,ħ@�4����;)�&�+2:"p�,�����X�^H`�E�������R��Ha�n+wzw�P�J���� ]OD��������k	PȔmY]�;����˵���
�*��"y8J2�R�����`��d,%mΒvX�;n�u����J�l�6&!C>״�v��Y�U]1D�]�g��F1D>�ӫ	�6Aes���:�*+���
��$IfW�w� ڤ	ՀX,w�I�l�M�b$[J{���<7FO�s����N�bf����f�қqB/~Iꚷ�Y����WW7^�E�z�v��J����r��Hzg��9+�d�Mب{��I�ڜ	�s4�ͷ� ق�"����~쮔ǩ$�;��p���?K'E'�;fKg1|YB�W<uJ�����AnKM�� ���x1;��U4��6�=�,oC�����N�a�̢!㯨����9�Bg�;\8o����=���"d����#;����7�m-�į}�s��{��h�91��D,��`�/�J��`m���\��FŒ�_tDӦe=�IރH�I9)\�N�i�ȍ�F�f���ʬP�w�����Tm[���߉�].)��y;L'��nbՃҊP��4c-��^����^���^
�F+i�VETY�:]�O��#3K�׵��f2�;�}B�H�r�I	��n-�^�x}DZ��0&�D|ݩ��*:����c�J`xwͭ������Zw�B�f�
�5inv4�W�~j�Z !�wDBs���A?[�Fx�h��S��{�S>���m#.�s����ǵFWURFn��s�|�.0ѧ��M���덏^�ƳR���M�x��^f]�Y��-�_ Q�����ϓ�tϿ�Q��b�7M{C.��,
b�~�0jEX׌�B՟h�n �i���EX3�(1�G��Q�=�{L�C~⒁�7��K�+�m=�<=���蠠cp��$�֏z_��qF�
��g��^v1	/^{fy�6��LF�Un1@Ct
�~�3��#\"8�r1���<*~�X=�?4r���?�[�!�G�Y�N()}b��fչ��\8��F_���e ���k`�I�����e�g�#�,�lE��r0�;5���u������'�T��0Pm�[�G��"�:X��~"�v�Ǜim�w��
p�#EƁ=~/8����/�MlU��g�����������҂/�;2�������/)���Fp6�^��fݩ�Y+g1yb�R+�:u��u
Q�V�Df�pp���&N5��U����9�P��_I� ᛳ�7�� g�`���\s��V�b
���I�5�k����/��e�F*�����p�����%*}�LW4��r���gU�G�3�;")�?����8�5�(�A-���⴦�Q� Cf�ʛ%W�2z9�=��M����P��D�e�>��U���,���"g5b	���>޳����
�O���|�-FfJ׻L��8�o����/~!^�o%ʴ��4��h��s���Z�0���E�BY�}kV����t��т���!I'G�W����kB,���6���[�/[;�:��j�?s�+�� �l�>6�f�*��w�x���O��6C֎]{�g�T���K��a���c`�������W�da���֫ U��|��d�+������W�\�yȰ�˳�\f=l*J ��,��|��vZ\I��Y��6��[0>��������[&�;�M�l}0�G	K�����zh�۽�����U�� ?���7i�����^���q	8P�ڄ�ظ���4@�R�UqCj,�-��5!��?��Ǳ�P�:�9��M��� k=|T#��I�����Jo`
X�����%��������C�x�X5L�V�v�o�7�����uO�K?&Bj�����:����a�P%�%�|mb7l����k����ѩ��E"��JGa�Wy�Φ�nƄ9wɁ	���ڞH"��Nm���&��{
�k�j��|o�@�-�K�&z�&���;g	cԓ�\��B^y
͝����+��Y�k"��&g�-f�J�1Q�@-�F��aP�v�|�_��˔�DÙ��B��%�{�>��n&~Eľ
�����a^�����]�RK�L�g��@uL��/�#���ۮ�AH�=Sv(�b����q ��n��Mu��&LEc�}�)�����*/�����cԤ�08c��v��"��\Ե�88gm�Yf�]ʜt�e"�'����H�%�g��x�tJ�o�x#�CH��iNN8;�ȅa\�z&&�sf��H�bx/�U^����>�Rv5J�U���$-WQ�rv:�n`�~�]f7a�,�_g�MgG��Ȣ��0qժ��Y���a@�p,?���}�BM"*F�ߞ.�잻�	)�&$I��M�9"4��G�:WRGe��t�xI6�����pxHv��²[m��]Z���݃YD�*"�K��z�(�t
�'����Re�d&#�oō�M D�j��_��i��
%�d1�]x.�)��Mz�@Yx6��_S�"�f�9/_��W���e*5g��j��;��	I�U����I��T\�l�?K��Kù5�YXj�z�b(��wU���^�{�N���
q�A��7`�H�qc"�6���Iꄱ����æSV�+_ju�r��\���d�?g2�JV����b�먞�PiP4��%�9�ƹ����/�6�L3#�VЋ2�U�����PZv�I�����d�Ld!Hb�T�ꣿ����U�G5G�"�KdYM�����G)��_w7>��[�-t���ed#����Ə4���+���a��*�V�D!�H��/��~�EYΛ�b�
��$7��/�9��B�L���(!F�\�w���pp�	����(��	�pi��D�O�n�^F�|��-���`�<���Ɓ������.9:w��P�o���59��1["\����T��qW�P�����=C]q䦉a����Y�,�It]�2��EJ���0�7a��E�h��2�J�a���S�8}� |b�}��`34����_����;�Hq7�N���7jA�{���b�{�)���9\���w
�w�S+��i4��)r Fa�C�����P��Gr�a;�)�+L~�/��h�e�^]����L�a��؞_���9�|��n֪�������jԹǺ,�_o�%�nzf�X�P���M�@� s�
N�O9%<V#���g��v��f-ʌpWn�q�TӕE��>D(��)�dm3'X�>��mP�y]����Pk [��;۬��J�c9#!1G����0��k��H ���y#|!���xUM���gasŘ��q����?�Ұ�K��j�����B�#���      V      