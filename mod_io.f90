module mod_io
    use precision, only: dp
    use parametre, only: dt, t_max,n
    use grille, only : X
    implicit none
    

    contains

    subroutine save_resultat(unit_id,t_courant, T)
       integer, intent(in) :: unit_id
       real(dp), intent(in) :: t_courant
       real(dp), intent(in) :: T(n)
       integer :: j

       do j=1, n
            write(unit_id, *) t_courant, X(j), T(j)
       end do
       write(unit_id, *)    ! Ligne vide pour séparer les étapes temporelles
       
    end subroutine save_resultat


end module mod_io