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
    t.def_figure('spectal_distribution') { spectral_distribution }
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

  def spectral_distribution
    t.do_box_labels('flux spectral density','$h\nu/kT$','$F_\nu/F$')
    xs = Dvector.new(100) { |i| 0.1+11.9*i/99.0 }
    ys = xs.pow(3).div(xs.exp.sub(1.0)).mul(0.154)
    xsc = Dvector[1.0,2.0,3.0,4.0,6.0,8.0,10.0,12.0]
    ysc = Dvector[0.0864,0.1837,0.2074,0.1772,0.0856,0.0314,0.01013,0.00305]
    t.show_plot(plot_boundaries(xs,ys,@margin)) do
      t.fill_color = White
      t.fill_frame
      t.show_polyline(xs,ys)
      t.show_marker('xs'=>xsc,'ys'=>ysc,'marker'=>BulletOpen,'scale'=>0.6)
    end
  end
  
end

MyPlots.new
