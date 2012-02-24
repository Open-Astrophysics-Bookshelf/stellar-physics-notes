program evaluate_rates
	real, parameter, dimension(7) :: cpp1 = [ -3.478630e+01,0.000000e+00,-3.511930e+00, &
			& 3.100860e+00,-1.983140e-01,1.262510e-02,-1.025170e+00 ]
	real, parameter, dimension(7) :: cpp2 = [ -4.364990e+01,-2.460640e-03,-2.750700e+00, &
			& -4.248770e-01,1.598700e-02,-6.908750e-04,-2.076250e-01 ]
	real, parameter, dimension(7) :: cpd = [ 8.935250e+00,0.000000e+00,-3.720800e+00, &
			& 1.986540e-01,0.000000e+00,0.000000e+00,3.333330e-01 ]
	real, parameter, dimension(7) :: che3n = [ 2.482430e+01,0.000000e+00, &
			& -1.227600e+01,-2.326820e-01,-4.975250e-01,0.000000e+00,-6.666670e-01 ]
	real, parameter, dimension(7) :: che3r = [ 2.289620e+01,0.000000e+00, &
			& -1.227600e+01,1.204710e+00,-2.689450e-02,0.000000e+00,3.333330e-01 ]
	

	real :: rho, T9
	rho = 83.2
	T9 = 0.0135
	write (*,'(A24,es11.4)') 'p+p -> d: ',rho*(NAsv(T9,cpp1) + NAsv(T9,cpp2))
	write (*,'(A24,es11.4)') 'd+p -> He3: ',rho*NAsv(T9,cpd)
	write (*,'(A24,es11.4)') 'He3+He3 -> He4 + p + p: ',rho*(NAsv(T9,che3n)+NAsv(T9,che3r))

	contains
	function NAsv(T9,c)
		real, intent(in) :: T9
		real, dimension(7), intent(in) :: c
		real :: NAsv
		real, parameter :: onethird = 1./3.,fivethird = 5./3.
		real :: T9inv
		real, dimension(7) :: T9fac
		integer :: i

		T9inv = 1.0/T9
		T9fac = [ 1.0,T9inv,T9inv**onethird,T9**onethird,T9,T9**fivethird,log(T9) ]

		NAsv = exp(dot_product(T9fac,c))
	end function NAsv
end program evaluate_rates
	