! ***********************************************************************
!
!   Copyright (C) 2010-2019  Bill Paxton & The MESA Team
!
!   this file is part of mesa.
!
!   mesa is free software; you can redistribute it and/or modify
!   it under the terms of the gnu general library public license as published
!   by the free software foundation; either version 2 of the license, or
!   (at your option) any later version.
!
!   mesa is distributed in the hope that it will be useful, 
!   but without any warranty; without even the implied warranty of
!   merchantability or fitness for a particular purpose.  see the
!   gnu library general public license for more details.
!
!   you should have received a copy of the gnu library general public license
!   along with this software; if not, write to the free software
!   foundation, inc., 59 temple place, suite 330, boston, ma 02111-1307 usa
!
! ***********************************************************************
 
      module run_star_extras

      use star_lib
      use star_def
      use const_def
      use math_lib
      
      implicit none
      
      ! these routines are called by the standard run_star check_model
      contains
      
          subroutine extras_controls(id, ierr)
             integer, intent(in) :: id
             integer, intent(out) :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
         
             ! this is the place to set any procedure pointers you want to change
             ! e.g., other_wind, other_mixing, other_energy  (see star_data.inc)


             ! the extras functions in this file will not be called
             ! unless you set their function pointers as done below.
             ! otherwise we use a null_ version which does nothing (except warn).

             s% extras_startup => extras_startup
             s% extras_start_step => extras_start_step
             s% extras_check_model => extras_check_model
             s% extras_finish_step => extras_finish_step
             s% extras_after_evolve => extras_after_evolve
             s% how_many_extra_history_columns => how_many_extra_history_columns
             s% data_for_extra_history_columns => data_for_extra_history_columns
             s% how_many_extra_profile_columns => how_many_extra_profile_columns
             s% data_for_extra_profile_columns => data_for_extra_profile_columns

             s% how_many_extra_history_header_items => how_many_extra_history_header_items
             s% data_for_extra_history_header_items => data_for_extra_history_header_items
             s% how_many_extra_profile_header_items => how_many_extra_profile_header_items
             s% data_for_extra_profile_header_items => data_for_extra_profile_header_items

          end subroutine extras_controls
      
      
          subroutine extras_startup(id, restart, ierr)
             integer, intent(in) :: id
             logical, intent(in) :: restart
             integer, intent(out) :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
          end subroutine extras_startup
      

          integer function extras_start_step(id)
             integer, intent(in) :: id
             integer :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
             extras_start_step = 0
          end function extras_start_step


          ! returns either keep_going, retry, or terminate.
          integer function extras_check_model(id)
             integer, intent(in) :: id
             integer :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
             extras_check_model = keep_going         
             if (.false. .and. s% star_mass_h1 < 0.35d0) then
                ! stop when star hydrogen mass drops to specified level
                extras_check_model = terminate
                write(*, *) 'have reached desired hydrogen mass'
                return
             end if


             ! if you want to check multiple conditions, it can be useful
             ! to set a different termination code depending on which
             ! condition was triggered.  MESA provides 9 customizeable
             ! termination codes, named t_xtra1 .. t_xtra9.  You can
             ! customize the messages that will be printed upon exit by
             ! setting the corresponding termination_code_str value.
             ! termination_code_str(t_xtra1) = 'my termination condition'

             ! by default, indicate where (in the code) MESA terminated
             if (extras_check_model == terminate) s% termination_code = t_extras_check_model
          end function extras_check_model


          integer function how_many_extra_history_columns(id)
             integer, intent(in) :: id
             integer :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
             how_many_extra_history_columns = 1
          end function how_many_extra_history_columns
      
      
          subroutine data_for_extra_history_columns(id, n, names, vals, ierr)
             integer, intent(in) :: id, n
             character (len=maxlen_history_column_name) :: names(n)
             real(dp) :: vals(n)
             integer, intent(out) :: ierr
             type (star_info), pointer :: s
             real(dp) :: G, M, R, mu, Pscale, rhoscale, Tscale             
                 
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
         
             ! note: do NOT add the extras names to history_columns.list
             ! the history_columns.list is only for the built-in history column options.
             ! it must not include the new column names you are adding here.
             names(1) = 'Pc_scaled'
             ! names(2) = 'Tc_scaled'
             ! names(3) = 'rhoc_scaled'

             ! Newton's constant, defined in module const_def (which
             ! is included at the top)
             G = standard_cgrav
             ! baryonic mass of the star, in gram; s is a data structure and is 
             ! described in $MESA_DIR/star_data/public/star_data.inc 
             M = s% mstar
             ! log_surface_radius is in units of Rsun, so we convert; Rsun
             ! is in const_def
             R = Rsun*exp10(s% log_surface_radius)
             ! central mean molecular weight
             mu = s% center_mu
             ! scalings for pressure, density, and temperature
             Pscale = G*M**2/R**4
             ! Tscale = ?
             ! rhoscale = ? 
             ! ***HINT***: the combination kB*NA, where kB = Boltzmann's
             ! constant and NA = Avogadro's number, is defined in const_def is 
             ! given the name cgas. You will need this to compute Tscale.
             !
      
             vals(1) = exp10(s% log_center_pressure) / Pscale
             ! vals(2) = ?
             ! vals(3) = ?

          end subroutine data_for_extra_history_columns

      
          integer function how_many_extra_profile_columns(id)
             integer, intent(in) :: id
             integer :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
             how_many_extra_profile_columns = 0
          end function how_many_extra_profile_columns
      
      
          subroutine data_for_extra_profile_columns(id, n, nz, names, vals, ierr)
             integer, intent(in) :: id, n, nz
             character (len=maxlen_profile_column_name) :: names(n)
             real(dp) :: vals(nz,n)
             integer, intent(out) :: ierr
             type (star_info), pointer :: s
             integer :: k
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
         
             ! note: do NOT add the extra names to profile_columns.list
             ! the profile_columns.list is only for the built-in profile column options.
             ! it must not include the new column names you are adding here.

             ! here is an example for adding a profile column
             !if (n /= 1) stop 'data_for_extra_profile_columns'
             !names(1) = 'beta'
             !do k = 1, nz
             !   vals(k,1) = s% Pgas(k)/s% P(k)
             !end do
         
          end subroutine data_for_extra_profile_columns


          integer function how_many_extra_history_header_items(id)
             integer, intent(in) :: id
             integer :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
             how_many_extra_history_header_items = 0
          end function how_many_extra_history_header_items


          subroutine data_for_extra_history_header_items(id, n, names, vals, ierr)
             integer, intent(in) :: id, n
             character (len=maxlen_history_column_name) :: names(n)
             real(dp) :: vals(n)
             type(star_info), pointer :: s
             integer, intent(out) :: ierr
             ierr = 0
             call star_ptr(id,s,ierr)
             if(ierr/=0) return

             ! here is an example for adding an extra history header item
             ! also set how_many_extra_history_header_items
             ! names(1) = 'mixing_length_alpha'
             ! vals(1) = s% mixing_length_alpha

          end subroutine data_for_extra_history_header_items


          integer function how_many_extra_profile_header_items(id)
             integer, intent(in) :: id
             integer :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
             how_many_extra_profile_header_items = 0
          end function how_many_extra_profile_header_items


          subroutine data_for_extra_profile_header_items(id, n, names, vals, ierr)
             integer, intent(in) :: id, n
             character (len=maxlen_profile_column_name) :: names(n)
             real(dp) :: vals(n)
             type(star_info), pointer :: s
             integer, intent(out) :: ierr
             ierr = 0
             call star_ptr(id,s,ierr)
             if(ierr/=0) return

             ! here is an example for adding an extra profile header item
             ! also set how_many_extra_profile_header_items
             ! names(1) = 'mixing_length_alpha'
             ! vals(1) = s% mixing_length_alpha

          end subroutine data_for_extra_profile_header_items


          ! returns either keep_going or terminate.
          ! note: cannot request retry; extras_check_model can do that.
          integer function extras_finish_step(id)
             integer, intent(in) :: id
             integer :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
             extras_finish_step = keep_going

             ! to save a profile, 
                ! s% need_to_save_profiles_now = .true.
             ! to update the star log,
                ! s% need_to_update_history_now = .true.

             ! see extras_check_model for information about custom termination codes
             ! by default, indicate where (in the code) MESA terminated
             if (extras_finish_step == terminate) s% termination_code = t_extras_finish_step
          end function extras_finish_step
      
      
          subroutine extras_after_evolve(id, ierr)
             integer, intent(in) :: id
             integer, intent(out) :: ierr
             type (star_info), pointer :: s
             ierr = 0
             call star_ptr(id, s, ierr)
             if (ierr /= 0) return
          end subroutine extras_after_evolve

      end module run_star_extras
      
