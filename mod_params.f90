module parametre
    use precision, only: dp
    implicit none
    integer :: n
    real(dp) :: L, dt, t_max
    real(dp) :: lambda, rho, cp
    real(dp) :: h, T_inf,T_init
    real(dp) :: A, x0, sigma

    namelist /params/ n, L, dt, t_max, lambda, rho, cp, h, T_inf,T_init, A, x0, sigma

    contains

    subroutine read_parameters(filename)
        integer :: unit_id
        character(len=*), intent(in) :: filename
        open(newunit=unit_id, file=filename, status='old', action='read')
        read(unit_id, nml=params)     
        close(unit_id)
    end subroutine read_parameters

   
end module parametre