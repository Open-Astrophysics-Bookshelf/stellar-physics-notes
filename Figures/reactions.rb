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
    t.def_figure('coulomb_integrand') { coulomb_integrand_with_legend }
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

  def coulomb_integrand_with_legend
    t.show_plot_with_legend(
        'plot_right_margin'=>0,
        'legend_left_margin'=>0.55
      ) { coulomb_integrand }
  end
  
  def coulomb_integrand
    t.do_box_labels('$p+p, T = 10^7\nsp\K$','$E$ (keV)','arb. units') #'$\exp\left[-(E_\mathrm{G}/E)^{1/2}-E/kT\right]$ (normalized)')
    npts = 500
    xs = Dvector.new(npts) { |i| 0.1+9.9*i/(npts-1.0) }
    yg = xs.div(489.2).sqrt().pow(-1).mul(-1).exp()
    yb = xs.div(-0.862).exp()
    yc = yg.mul(yb)
    ycmax= yc.max
    yc.div!(ycmax)
    maxpt = yc.where_closest(1.0)
    yb.div!(yb[maxpt])
    yg.div!(yg[maxpt])
    bmax = yb.where_le(1.5)
    gmax = yg.where_ge(1.5)
    ygauss = (xs-4.54).pow(2).mul(-0.194).exp().mul(yc.max())
    t.yaxis_log_values
    t.show_plot(plot_boundaries(xs,yc,@margin,nil,1.5)) do
      t.fill_color = White
      t.fill_frame
      t.show_polyline(xs,yc,
            Blue,'$\exp\left[-(E_\mathrm{G}/E)^{1/2}-E/kT\right]$',LINE_TYPE_SOLID)
      t.show_polyline(xs,ygauss,Red,'approx.',LINE_TYPE_DOT_DASH)
      t.show_polyline(xs[0..gmax],yg[0..gmax],
        LightGrey,'$\exp\left[-(E_\mathrm{G}/E)^{1/2}\right]$',LINE_TYPE_DOT)
      t.show_polyline(xs[bmax..-1],yb[bmax..-1],
        LightGrey,'$\exp\left[-E/kT\right]$',LINE_TYPE_DASH)
    end
  end
  
end

MyPlots.new
