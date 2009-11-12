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
    @data_file = ["wdm_mi.data","wdm_mc.data"]
    @data_array = [ @mass = Dvector.new,
                    @initial_core_mass = Dvector.new,
                    @final_core_mass = Dvector.new ]
    @have_data = false
    t.def_figure('vary_core_mass') { vary_core_mass }
    t.def_figure('vary_stellar_mass') { vary_stellar_mass }
    t.def_figure('core_mass_combined') { two_up }
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

  def vary_core_mass
    read_data(@data_file[1])
    t.do_box_labels('$M_0 = 2.0\nsp\Msun$','initial core mass (\Msun)',
        'final core mass (\Msun)')
    xs = @initial_core_mass
    ys = @final_core_mass
    t.show_plot(plot_boundaries(xs,ys,@margin)) do
      t.show_polyline(xs,ys)
    end
  end

  def vary_stellar_mass
    read_data(@data_file[0])
    t.do_box_labels('$M_{\mathrm{core},0} = 0.55\nsp\Msun$','initial stellar mass (\Msun)',
        'final core mass (\Msun)')
    xs = @mass
    ys = @final_core_mass
    t.show_plot(plot_boundaries(xs,ys,@margin)) do
      t.show_polyline(xs,ys)
    end
  end
  
  def two_up
    t.landscape
#    t.do_box_labels(nil,nil,'final core mass (\Msun)')
    t.subplot('right_margin'=>0.5) {
      t.yaxis_loc = t.ylabel_side = LEFT; t.right_edge_type = AXIS_LINE_ONLY
      vary_core_mass
    }
    t.subplot('left_margin'=>0.5) {
      t.yaxis_loc = t.ylabel_side = RIGHT; t.left_edge_type = AXIS_LINE_ONLY
      vary_stellar_mass
    }
  end
  
  def read_data(file)
    Dvector.read(file,@data_array)
    @have_data = true
  end
    
end

MyPlots.new
