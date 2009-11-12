# reactions.rb

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
    t.def_figure('coulomb_integrand') { coulomb_integrand }
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

  def coulomb_integrand
    t.do_box_labels('$p+p, T = 10^7\nsp\K$','$E$ (keV)','$\exp\left[-(E_\mathrm{G}/E)^{1/2}-E/kT\right]$ (normalized)')
    xs = Dvector.new(100) { |i| 0.1+9.9*i/99.0 }
    yg = xs.div(489.2).sqrt().pow(-1).mul(-1).exp()
    yb = xs.div(-0.862).exp()
    yc = yg.mul(yb)
    yc.div!(yc.max)
    ygauss = (xs-4.54).pow(2).mul(-0.194).exp().mul(yc.max())
    t.yaxis_log_values
    t.show_plot(plot_boundaries(xs,yc,@margin)) do
      t.fill_color = White
      t.fill_frame
      t.show_polyline(xs,yc)
      t.show_polyline(xs,ygauss,nil,nil,LINE_TYPE_DASH)
    end
  end
  
end

MyPlots.new
