using AtomsBase
using Unitful
using Test

@testset "Printing atomic systems" begin
    at = Atom(:Si, zeros(3) * u"m", extradata=42)
    @test repr(at) == "Atom(Si, [0.0, 0.0, 0.0]u\"m\")"
    
    atoms = [:Si => [0.0, -0.125, 0.0],
             :C  => [0.125, 0.0, 0.0]]
    box = [[10, 0.0, 0.0], [0.0, 5, 0.0], [0.0, 0.0, 7]]u"Å"

    flexible_system = periodic_system(atoms, box; fractional=true)
    @test repr(flexible_system) == """
    FlexibleSystem(CSi, Periodic, box=[[10.0, 0.0, 0.0], [0.0, 5.0, 0.0], [0.0, 0.0, 7.0]]u"Å")"""

    fast_system = FastSystem(flexible_system)
    @test repr(fast_system) == """
    FastSystem(CSi, Periodic, box=[[10.0, 0.0, 0.0], [0.0, 5.0, 0.0], [0.0, 0.0, 7.0]]u"Å")"""
end
