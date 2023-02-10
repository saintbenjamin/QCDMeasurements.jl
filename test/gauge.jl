using Gaugefields
function SU3test()
    println("SU3test")
    NX = 4
    NY = 4
    NZ = 4
    NT = 4
    Nwing = 0
    Dim = 4
    NC = 3

    U = Initialize_4DGaugefields(NC,Nwing,NX,NY,NZ,NT,condition = "cold")
    
    filename = "./conf_00000008.ildg"
    ildg = ILDG(filename)
    i = 1
    L = [NX,NY,NZ,NT]
    load_gaugefield!(U,i,ildg,L,NC)

    m_plaq = Plaquette_measurement(U)
    m_poly = Polyakov_measurement(U)
    m_pion = Pion_correlator_measurement(U)
    m_pion_Staggered = Pion_correlator_measurement(U,fermiontype = "Staggered")
    m_pion_Wilson = Pion_correlator_measurement(U,fermiontype = "Wilson")

    plaq = get_value(measure(m_plaq,U))
    poly = get_value(measure(m_poly,U))
    println("plaq: $plaq")
    println("poly: $poly")

    m_energy = Energy_density_measurement(U)
    m_topo = Topological_charge_measurement(U)
    energy = get_value(measure(m_energy,U))
    topo = get_value(measure(m_topo,U))
    println("energy: $energy")
    println("topo: $topo")


    pion = get_value(measure(m_pion,U))
    pion_s = get_value(measure(m_pion_Staggered,U))
    pion_w = get_value(measure(m_pion_Wilson,U))

    println("pion: $pion")
    println("pion correlator with Staggered fermion: $pion_s")
    println("pion correlator with  Wilson fermion: $pion_w")

    m_chiral_Staggered = Chiral_condensate_measurement(U,fermiontype = "Staggered")
    m_chiral_Wilson = Chiral_condensate_measurement(U,fermiontype = "Wilson")
    chiral_s = get_value(measure(m_chiral_Staggered,U))
    chiral_w = get_value(measure(m_chiral_Wilson,U))

    println("Chiral condensate with Staggered fermion: $chiral_s")
    println("Chiral condensatewith  Wilson fermion: $chiral_w")



end
SU3test()