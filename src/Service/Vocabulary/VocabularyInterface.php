<?php

namespace Casebox\CoreBundle\Service\Vocabulary;

/**
 * Interface VocabularyInterface
 */
interface VocabularyInterface
{
    /**
     * Load and return all terms
     * @return array
     */
    public function getTerms();
}
