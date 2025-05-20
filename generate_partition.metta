
(= (generate-partitions subsets original)
   (let* ((subsets-list (get-children (get-children subsets)))
          (original-set (set (get-children original)))
          
          (backtrack (lambda (current used)
             (if (= used original-set)
                 (add partitions (tuple (sort current)))
                 (for subset in subsets-list
                      (if (not (any (lambda (elem) (in elem used)) subset))
                          (begin
                             (backtrack (append current subset) (union used (set subset)))
                             (pop current))))))))
          
          (filtered-subsets (map (lambda (s) (tuple (sort s)))
                               (filter (lambda (s) (and (not (empty? s)) (not (= (set s) original-set))))
                                      subsets-list)))
          
          (partitions (set)))
      
      (backtrack [] (set))
      (parse-to-expr (str (list partitions))))