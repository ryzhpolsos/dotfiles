from kitty.tab_bar import draw_tab_with_powerline, powerline_symbols

def draw_tab(draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data):
    powerline_symbols['slanted'] = ('', '│')
    return draw_tab_with_powerline(draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data)
