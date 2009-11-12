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
    @N = Dvector.new
    @Z = Dvector.new
    @E = Dvector.new
    @line = 0
    @data_array = [@Z, @N, @E]
    @num_lines = 1
    @header = Dvector[@num_lines]
    t.def_figure('most_bound') { most_bound }
    t.def_figure('neutron_drip') { neutron_drip }
    t.def_figure('proton_drip') { proton_drip }
    t.def_figure('combined_plot') { nuclide_chart }
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

  def nuclide_chart
    t.landscape
    t.do_box_labels('Nuclide Chart','$N$','$Z$')
    t.subplot { most_bound }
    t.subplot { neutron_drip }
    t.subplot { proton_drip }
  end

  def most_bound
    read_data("Zstar.data")
    xs = @N
    ys = @Z
    t.do_box_labels('$Z_\star$','$N$','$Z$')
    t.show_plot(plot_boundaries([0,200],[0,100],@margin)) do
      t.show_marker('xs'=>xs,'ys'=>ys,'marker'=>Bullet,'scale'=>0.2)
    end
  end

  def neutron_drip
    read_data("neutron_drip.data")
    xs = @N
    ys = @Z
    t.do_box_labels('neutron dripline','$N$','$Z$')
    t.show_plot(plot_boundaries([0,200],[0,100],@margin)) do
      t.show_marker('xs'=>xs,'ys'=>ys,'marker'=>Bullet,'scale'=>0.2,'color'=>Red)
    end
  end

  def proton_drip
    read_data("proton_drip.data")
    xs = @N
    ys = @Z
    t.do_box_labels('protron dripline','$N$','$Z$')
    t.show_plot(plot_boundaries([0,200],[0,100],@margin)) do
      t.show_marker('xs'=>xs,'ys'=>ys,'marker'=>Bullet,'scale'=>0.2,'color'=>Blue)
    end
  end

  def read_data(data_filename)
    Dvector.read(data_filename,@data_array)
  end
end

MyPlots.new
