class testmod (
  String $somestring = 'default',
) {
  notify { "Output: ${myfunction($somestring)}": }
  notify { "Gethostconfig: ${gethostconfig('test')}": }
}
