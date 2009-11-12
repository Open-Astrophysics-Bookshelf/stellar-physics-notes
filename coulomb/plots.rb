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
    @lgM = Dvector.new(101) { |i| -2.0 + (i-1)*0.04}
    @lgR = Dvector.new
    # constants when mass and radius are in Jovian units 
    @b = 1.03
    @a = 2.90
    @onethird = 1.0/3.0
    t.def_figure('RM_combined') { rm_combined_with_legend }
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

  def rm_combined_with_legend
    t.show_plot_with_legend('legend_left_margin'=>0.1,
          'plot_right_margin'=>0) { rm_combined }
  end
  
  def rm_combined
    t.do_box_labels(nil,'$M/M_{\mathrm{J}}$','$R/R_{\mathrm{J}}$')
    xs = @lgM
    m13 = xs.mul(@onethird).exp10
    ssm = Dvector[1.0,0.3,0.046,0.054]
    ssm.log10!
    ssr = Dvector[1.0,0.85,0.36,0.35]
    t.xaxis_log_values=true
    t.show_plot(plot_boundaries(xs,[0.2,1.5],@margin)) do
      # hydrogen
      a = @a
      b = @b
      ys = rm(a,b,m13)
      t.show_polyline(xs,ys,Black,'H',LINE_TYPE_SOLID)
      # X = 0.71, Y = 0.29
      abar = 1.0/(0.71 + 0.29/4)
      zbar = abar*(0.71 + 0.29*0.5)
      a = @a*(zbar/abar).pow(5.0*@onethird)
      b = @b*zbar*zbar/abar.pow(4.0*@onethird)
      ys = rm(a,b,m13)
      t.show_polyline(xs,ys,Black,'$X = 0.71$',LINE_TYPE_DOT_DASH)
      # helium
      a = @a*0.31
      b = @b*0.63
      ys = rm(a,b,m13)
      t.show_polyline(xs,ys,Black,'\helium',LINE_TYPE_DOTS)
      # carbon
      a = @a*0.31
      b = @b*1.31
      ys = rm(a,b,m13)
      t.show_polyline(xs,ys,Black,'\carbon',LINE_TYPE_DASH)
      t.show_marker('xs'=>ssm,'ys'=>ssr,'marker'=>Bullet)
    end    
  end

  def rm(a,b,m13)
    r = m13.mul(a).div(m13.pow(2).plus(b))
    return r
  end

end

MyPlots.new
