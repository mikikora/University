use std::collections::HashMap;

fn dna_strand(dna: &str) -> String {
    let pairs: HashMap<char, char> = [('T', 'A'), ('A', 'T'), ('G','C'), ('C', 'G')].iter().cloned().collect();
    dna.chars().map(|x| pairs.get(&x).unwrap()).collect()
}


#[cfg(test)]
mod tests {
    use super::dna_strand;

    #[test]
    fn returns_expected() {
      assert_eq!(dna_strand("AAAA"),"TTTT");
      assert_eq!(dna_strand("ATTGC"),"TAACG");
      assert_eq!(dna_strand("GTAT"),"CATA");
      assert_eq!(dna_strand("CTTATTTTTTCTCTCGTTACCTTACGGCTATCCTTCTTGCTCCCTAAGAG"), "GAATAAAAAAGAGAGCAATGGAATGCCGATAGGAAGAACGAGGGATTCTC");
      assert_eq!(dna_strand("AACATTGTTAGGTAGGCATACTACAGCAGCTGATCTAAGCCTTGACCCCT"), "TTGTAACAATCCATCCGTATGATGTCGTCGACTAGATTCGGAACTGGGGA");
    }
}
