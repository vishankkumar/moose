[Mesh]
  file = rect-2blk.e
  # This test will not work in parallel with ParallelMesh enabled
  # due to a bug in PeriodicBCs.
  distribution = serial
[]

[Variables]
  active = 'u v'

  [./u]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]

  [./v]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  active = 'diff_u diff_v'

  [./diff_u]
    type = Diffusion
    variable = u
    block = 1
  [../]

  [./diff_v]
    type = Diffusion
    variable = v
  [../]
[]

[BCs]
  active = 'Periodic left_u right_u left_v right_v'

  [./Periodic]
    [./u]
      variable = u
      primary = 1
      secondary = 5
      translation = '0 1 0'
    [../]

    [./v1]
      variable = v
      primary = 1
      secondary = 5
      translation = '0 1 0'
    [../]
    [./v2]
      variable = v
      primary = 2
      secondary = 4
      translation = '0 1 0'
    [../]
  [../]

  [./left_u]
    type = DirichletBC
    variable = u
    boundary = 6
    value = 0
  [../]

  [./right_u]
    type = NeumannBC
    variable = u
    boundary = 8
    value = 4
  [../]

  [./left_v]
    type = DirichletBC
    variable = v
    boundary = 6
    value = 1
  [../]

  [./right_v]
    type = DirichletBC
    variable = v
    boundary = 3
    value = 6
  [../]
[]

[Executioner]
  type = Steady
  petsc_options = '-snes_mf_operator'
[]

[Output]
  file_base = out_restrict
  output_initial = false
  interval = 1
  exodus = true
  perf_log = true
[]
