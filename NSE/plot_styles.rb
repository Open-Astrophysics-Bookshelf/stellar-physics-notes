# plot_styles.rb

require 'Tioga/FigureMaker'

module MyPlotStyles
  
  include FigureConstants
  
  
  def sans_serif_style(t = FigureMaker.default)
    set_default_plot_style
    t.tex_fontfamily = 'sfdefault'
    t.xaxis_numeric_label_tex = '$\mathsf{#1}$'
    t.yaxis_numeric_label_tex = '$\mathsf{#1}$'
  end
  
  
  def set_default_plot_style(t = FigureMaker.default)
    
  # Page size and margins
    # these default values are used by the default_enter_page_function

    t.default_page_width = 72*5.5 # in big-points (1/72 inch)
    t.default_page_height = 72*4.25 # in big-points (1/72 inch)

    t.default_frame_left = 0.15 # as fraction of width from left edge
    t.default_frame_right = 0.85 # as fraction of width from left edge
    t.default_frame_top = 0.85 # as fraction of width from bottom edge
    t.default_frame_bottom = 0.15 # as fraction of width from bottom edge

  # Graphics
    t.default_line_scale = 1
    t.line_cap = LINE_CAP_ROUND
    t.line_join = LINE_JOIN_ROUND
    t.line_type = LINE_TYPE_SOLID
    t.line_width = 1.2
    t.miter_limit = 2
    t.stroke_opacity = 1
    t.fill_opacity = 1

  # Markers   
    t.marker_defaults = { 
        'fill_color' => Black,
        'stroke_color' => Black,
        'scale' => 1,
        'angle' => 0,
        'justification' => CENTERED,
        'alignment' => ALIGNED_AT_MIDHEIGHT,
        'horizontal_scale' => 1.0,
        'vertical_scale' => 1.0,
        'italic_angle' => 0.0,
        'ascent_angle' => 0.0 }

  # TeX text
    t.tex_preamble = '% start of preamble.  
        \usepackage[dvipsnames,usenames]{color} % need this for text colors
        \usepackage{txfonts}
        \input{MyNotation}
        \input{nuclides}
    '

    t.tex_fontsize = '10.0'  
    t.tex_fontfamily = 'rmdefault'
    t.tex_fontseries = 'mddefault'
    t.tex_fontshape = 'updefault'

    t.alignment = ALIGNED_AT_BASELINE
    t.justification = CENTERED

    t.label_bottom_margin = 0
    t.label_left_margin = 0
    t.label_right_margin = 0
    t.label_top_margin = 0

    t.text_shift_from_x_origin = 1.8
    t.text_shift_from_y_origin = 2.0
    t.text_shift_on_bottom = 2.0
    t.text_shift_on_left = 1.8
    t.text_shift_on_right = 2.5
    t.text_shift_on_top = 0.7

  # Titles
    t.title_alignment = ALIGNED_AT_BASELINE
    t.title_angle = 0
    t.title_color = Black
    t.title_justification = CENTERED
    t.title_position = 0.5
    t.title_scale = 1.1
    t.title_shift = 0.7
    t.title_side = TOP

  # Xaxis
    t.xaxis_digits_max = 0 
    t.xaxis_line_width = 1
    t.xaxis_loc = BOTTOM
    t.xaxis_log_values = false
    t.xaxis_major_tick_length = 0.6
    t.xaxis_major_tick_width = 0.9
    t.xaxis_min_between_major_ticks = 2
    t.xaxis_minor_tick_length = 0.3
    t.xaxis_minor_tick_width = 0.7
    t.xaxis_number_of_minor_intervals = 0
    t.xaxis_numeric_label_alignment = ALIGNED_AT_MIDHEIGHT
    t.xaxis_numeric_label_angle = 0
    t.xaxis_numeric_label_decimal_digits
    t.xaxis_numeric_label_justification = CENTERED
    t.xaxis_numeric_label_scale = 1.0
    t.xaxis_numeric_label_shift = 0.3
    t.xaxis_numeric_label_tex = '$#1$'
    t.xaxis_stroke_color = Black
    t.xaxis_ticks_inside = true
    t.xaxis_ticks_outside = false
    t.xaxis_tick_interval = 0
    t.xaxis_type = AXIS_WITH_TICKS_AND_NUMERIC_LABELS
    t.xaxis_use_fixed_pt = false

  # Yaxis
    t.yaxis_digits_max = 0 
    t.yaxis_line_width = 1
    t.yaxis_loc = LEFT
    t.yaxis_log_values = false
    t.yaxis_major_tick_length = 0.6
    t.yaxis_major_tick_width = 0.9
    t.yaxis_min_between_major_ticks = 2
    t.yaxis_minor_tick_length = 0.3
    t.yaxis_minor_tick_width = 0.7
    t.yaxis_number_of_minor_intervals = 0
    t.yaxis_numeric_label_alignment = ALIGNED_AT_MIDHEIGHT
    t.yaxis_numeric_label_angle = -90
    t.yaxis_numeric_label_decimal_digits = -1
    t.yaxis_numeric_label_justification = CENTERED
    t.yaxis_numeric_label_scale = 1.0
    t.yaxis_numeric_label_shift = 0.5
    t.yaxis_numeric_label_tex = '$#1$'
    t.yaxis_stroke_color = Black
    t.yaxis_ticks_inside = true
    t.yaxis_ticks_outside = false
    t.yaxis_tick_interval = 0
    t.yaxis_type = AXIS_WITH_TICKS_AND_NUMERIC_LABELS
    t.yaxis_use_fixed_pt = false

  # Plot edges
    t.top_edge_type = EDGE_WITH_TICKS
    t.bottom_edge_type = EDGE_WITH_TICKS
    t.left_edge_type = EDGE_WITH_TICKS
    t.right_edge_type = EDGE_WITH_TICKS

  # Xaxis Labels
    t.xlabel_alignment = ALIGNED_AT_BASELINE
    t.xlabel_angle = 0
    t.xlabel_color = Black
    t.xlabel_justification = CENTERED
    t.xlabel_position = 0.5
    t.xlabel_scale = 1.0
    t.xlabel_shift = 2.0
    t.xlabel_side = BOTTOM

  # Yaxis Labels
    t.ylabel_alignment = ALIGNED_AT_BASELINE
    t.ylabel_angle = 0
    t.ylabel_color = Black
    t.ylabel_justification = CENTERED
    t.ylabel_position = 0.5
    t.ylabel_scale = 1.0
    t.ylabel_shift = 2.4
    t.ylabel_side = LEFT

  # Legends
    t.legend_alignment = ALIGNED_AT_BASELINE
    t.legend_justification = LEFT_JUSTIFIED
    t.legend_line_dy = 0.4
    t.legend_line_width = -1
    t.legend_line_x0 = 0.5
    t.legend_line_x1 = 2.0
    t.legend_scale = 0.8
    t.legend_text_dy = 1.9
    t.legend_text_width = -1
    t.legend_text_xstart = 2.8
    t.legend_text_ystart = 2.0
    t.legend_defaults = { 
        'legend_top_margin' => 0.03,
        'legend_bottom_margin' => 0.03,
        'legend_left_margin' => 0.83,
        'legend_right_margin' => 0.0,
        'plot_top_margin' => 0.0,
        'plot_bottom_margin' => 0.0,
        'plot_left_margin' => 0.0,
        'plot_right_margin' => 0.18,
        'plot_scale' => 1,
        'legend_scale' => 1 }

  end

end
