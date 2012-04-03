program wdmass
  use agb
  integer, parameter :: Niter = 20
  character(len=*), parameter :: output_format = '(3(f9.4))'
  real :: mc, m0, w, mwd
  integer :: ierr, i
  
  w = 56.0
  vary_core_mass: do i = 1, Niter
    mc = 0.55 + 0.2*real(i-1)/real(Niter-1)
    m0 = 2.0
    mwd = white_dwarf_mass(m0,mc,w,ierr)
    if (ierr /= 0) exit
    write (*,output_format) m0,mc,mwd
  end do vary_core_mass
  
  vary_initial_mass: do i = 1, Niter
    m0 = 1.0 + 5.0*real(i-1)/real(Niter-1)
    mc = 0.55
    mwd = white_dwarf_mass(m0,mc,w,ierr)
    if (ierr /= 0) exit
    write (*,output_format) m0,mc,mwd
  end do vary_initial_mass
end program wdmass
