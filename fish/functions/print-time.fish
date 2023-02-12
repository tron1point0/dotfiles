function print-time -a host
    function __luminance -a r256 -a g256 -a b256
        # Gamma correction
        function __gamma -a x
            set -l s (math 0x$x / 256)
            if test $s -le 0.03928
                math $s / 12.92
            else
                math \( \($s + 0.055\) / 1.055 \) ^ 2.4
            end
        end

        set -l r (__gamma $r256)
        set -l g (__gamma $g256)
        set -l b (__gamma $b256)

        # WCAG luminance (https://www.w3.org/TR/2008/REC-WCAG20-20081211/)
        math 0.2126 \* $r + 0.7152 \* $g + 0.0722 \* $b
    end

    function __textcolor -a color
        set -l r (string sub -s1 -l2 $color)
        set -l g (string sub -s3 -l2 $color)
        set -l b (string sub -s5 -l2 $color)

        if test (__luminance $r $g $b) -gt 0.179
            echo 000000
        else
            echo ffffff
        end
    end

    if test -z $host
        set -f host $hostname
    end

    set -l hostname_color '444444'
    set -l bg_color (echo $host | sha1sum | string sub -l6 | rev)
    set -l fg_color (__textcolor $bg_color)

    set_color -b $hostname_color $bg_color ; echo -n ''
    set_color -b $bg_color $fg_color ; date +' %R ' | tr -d '\n'
    set_color -b normal $bg_color ; echo -n ''
    set_color normal
end
