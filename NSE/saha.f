! saha.f
! module contain function and driver program to find the NSE abundances
! of a 56Ni - 4He mixture.
!
! AST 840, Spring 2010
! Edward Brown, Michigan State University
!
module saha
  integer, parameter :: i_T9 = 1
  integer, parameter :: i_rho7 = 2
  integer, parameter :: Npar = 2
  
  real, parameter, private :: aX = 1.0/14.0, &
    & aR = -13.0/14.0, aT = 39.0/28.0, Q = 72.8, NQ = 9.40e3 
  
contains
  function find_xhe(x4,ipar,rpar,ierr) result(r)
    real, intent(in) :: x4
    integer, dimension(:), intent(inout) :: ipar
    real, dimension(:), intent(inout) :: rpar
    integer, intent(out) :: ierr
    real :: r
    real :: T9, rho7
    
    ierr = 0
    T9 = rpar(i_T9)
    rho7 = rpar(i_rho7)
    r = x4 - (1.0-x4)**aX * NQ * rho7**aR * T9**aT * exp(-Q/T9)
  end function find_xhe
  
  function find_T(T9,ipar,rpar,ierr) result(r)
    implicit none
    real, intent(in) :: T9
    integer, dimension(:), intent(inout) :: ipar
    real, dimension(:), intent(inout) :: rpar
    integer, intent(out) :: ierr
    real :: r
    real :: x4
    
    rpar(i_T9) = T9
    x4 = 0.5
    r = find_xhe(0.5,ipar,rpar,ierr)
  end function find_T
end module saha

program solve_nse
  use rootfind
  use saha
  integer :: i,ierr
  real :: x4, Thalf, rho7, T9
  real, parameter :: tol = 1.0e-8
  integer, dimension(0) :: ipar
  real, dimension(Npar) :: rpar
  
  rho7 = 1.0
  ! vary T9 from 4.5 to 6.5 and solve for x
  print '(a5,tr2,2(a11,tr2))','T9','X4','X56'
  print '("=====",tr2,2(11("="),tr2))'
  do i = 450, 650
    T9 = real(i)*0.01
    rpar(i_T9) = T9
    rpar(i_rho7) = rho7
    x4 = bisection(0.0,1.0,tol,find_xhe,ipar,rpar,ierr)
    if (ierr < 0) exit
    print '(f5.2,tr2,2(g11.4,tr2))',T9,x4,1.0-x4
  end do
  
  ! now find temperature at which xhe = xni = 0.5
  rpar(i_rho7) = rho7
  Thalf = bisection(5.9,6.0,tol,find_T,ipar,rpar,ierr)
  if (ierr < 0) stop
  print '(/,A,f6.3)','T9(X4 = X56) = ',Thalf
end program solve_nse
  
  