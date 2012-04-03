! agb.f
! simple example of how core-mass growth and mass loss from wind
! on the AGB sets the white dwarf initial mass
module agb
  ! flags for parameter array
  integer, parameter :: i_stellar_mass = 1, &
                        & i_core_mass = 2, &
                        & i_wind_loss_coeff = 3
  integer, parameter :: number_agb_parameters = 3
  real, parameter :: mcmin = 0.52
  contains
  
  function white_dwarf_mass(m0,mc0,w,ierr) result(mwd)
    use rootfind
    real, intent(in) :: m0, mc0, w
    integer, intent(out) :: ierr
    real :: mwd
    real, parameter :: m1 = mcmin,  m2 = 1.4, tol = epsilon(m2)
    real, dimension(number_agb_parameters) :: rpar
    integer, dimension(0) :: ipar
    
    ! stuff the parameter array
    rpar(i_stellar_mass) = m0
    rpar(i_core_mass) = mc0
    rpar(i_wind_loss_coeff) = w
    
    mwd = bisection(m1,m2,tol,fcn,ipar,rpar,ierr)
  end function white_dwarf_mass
  
  function fcn(m,ipar,rpar,ierr) result(D)
    real, intent(in) :: m
    integer, dimension(:), intent(inout) :: ipar
    real, dimension(:), intent(inout) :: rpar
    integer, intent(out) :: ierr
    real :: D
    real :: m0, mc0, c
  
    ierr = 0
    m0 = rpar(i_stellar_mass)
    mc0 = rpar(i_core_mass)
    c = rpar(i_wind_loss_coeff)
  
    ! check-input
    if (m < mcmin) then
      ierr = -9
      D = -huge(1.0)
      return
    end if
    
    D = m**2 - m0**2 + c*((m-mcmin)**1.5 - (mc0-mcmin)**1.5)
  end function fcn
end module agb
