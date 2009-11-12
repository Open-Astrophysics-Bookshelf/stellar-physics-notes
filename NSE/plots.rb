# plots.rb

require 'Tioga/FigureMaker'

require 'plot_styles'

class MyPlots

  include Math
  include Tioga
  include FigureConstants
  include MyPlotStyles

  def t
    @figure_maker
  end

  def initialize
    @figure_maker = FigureMaker.default

    t.save_dir = 'plots_out'
    t.def_eval_function { |str| eval(str) }
    @margin = 0.1
    @data_file = "nse.data"
    @data_array = [ @T9 = Dvector.new,
                    @X4 = Dvector.new,
                    @X56 = Dvector.new ]
    @have_data = false
    t.def_figure('mass_fraction') { mass_fraction_with_legend }
    t.def_enter_page_function { enter_page }
  end
  
  def enter_page
    set_default_plot_style
    t.default_enter_page_function
  end
  
  def plot_boundaries(xs,ys,margin,ymin=nil,ymax=nil)
    xmin = xs.min
    xmax = xs.max
    ymin = ys.min if ymin == nil
    ymax = ys.max if ymax == nil
    width = (xmax == xmin)? 1 : xmax - xmin
    height = (ymax == ymin)? 1 : ymax - ymin
    left_boundary = xmin - margin * width
    right_boundary = xmax + margin * width
    top_boundary = ymax + margin * height
    bottom_boundary = ymin - margin * height
    return [ left_boundary, right_boundary, top_boundary, bottom_boundary ]
  end

  def mass_fraction_with_legend
    read_data
    t.show_plot_with_legend() { mass_fraction }
  end

  def mass_fraction
    read_data
    t.do_box_labels('\helium, \nickel[56] abundances','$T/(10^9\nsp\K)$','$X$')
    xs = @T9
    ys4 = @X4
    ys56= @X56
    t.show_plot(plot_boundaries(xs,ys4,@margin)) do
      t.show_polyline(xs,ys4,Blue,'$X_{4}$',LINE_TYPE_SOLID)
      t.show_polyline(xs,ys56,Red,'$X_{56}$',LINE_TYPE_DASH)
    end
  end
  
  def read_data
    if @have_data
      return
    end
    Dvector.read(@data_file,@data_array,3,201)
    @have_data = true
  end
    
end

MyPlots.new
