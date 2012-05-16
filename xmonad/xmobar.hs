Config {
    font = "xft:DejaVu Sans-9",
    position = Bottom,
    template = "%XMonadLog% }{ ❙ <fc=#96FFA4>♫ %default:Master%</fc> ❙ %KAUS% ❰ <fc=lightblue>%date%</fc> ❱ ",
    commands = [
        Run Volume "default" "Master" [
            "-t", "<volume> <status>",
            "-S", "On" ] 5,
        Run Weather "KAUS" [
            "-t", "<skyCondition> <tempC>°C",
            "-L", "18",
            "-H", "28",
            "-n", "green",
            "-h", "red",
            "-l", "lightblue",
            "-S", "On" ] 3000,
        Run Date "%Y-%m-%d %T" "date" 10,
        Run XMonadLog
    ]
}
