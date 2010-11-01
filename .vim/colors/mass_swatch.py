from __future__ import with_statement
import re
import sys


def hex2dec(s):
    return int(s, 16)

def render_file(filename, items):
    out_filename = filename.split('.')[0] + '.htm'
    out_file = open(out_filename, "w")

    out_file.write("""
        <html>
        <head>
        <style>
            .colorblock
            {
                width: 24px;
                height: 24px;
                border: 1px solid #000;
                padding: 5px;
                margin-right: 5px;
            }

            td
            {
                width: 400px;
                padding: 10px;
            }
        </style>
        </head>
        <body>
        <table>""");

    for item in items:

        column = []
        column.append(item[0])

        out_file.write('<tr><td>' + item[0] + '</td><td>')

        for color in item[1]:
            out_file.write('<span class="colorblock" style="background-color: ' + color[0] + '">' + str(color[1]) + '</span>')

        out_file.write('</td></tr>')

    out_file.write("</table></body></html>")

if __name__ == "__main__":
    
    filename = sys.argv[1]

    reg = r'#[a-zA-Z0-9]{3,6}'
    items = []

    with open(filename) as file:
        for line in file:
            colors = re.findall(reg, line)
            
            rgb = []
            combined = []

            for color in colors:
                rgb = (hex2dec(color[1:3]), hex2dec(color[3:5]), hex2dec(color[5:7]))
                combined.append( (color, rgb) )
            
            if len(colors) == 0:
                continue

            items.append( (line, combined) )

    render_file(filename, items)


