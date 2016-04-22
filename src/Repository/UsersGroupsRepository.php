<?php

namespace Casebox\CoreBundle\Repository;

use Casebox\CoreBundle\Entity\UsersGroups;

/**
 * UsersGroupsRepository
 */
class UsersGroupsRepository extends \Doctrine\ORM\EntityRepository
{
    /**
     * @param string $username
     *
     * @return UsersGroups|null
     */
    public function findUserByUsername($username)
    {
        $user = $this->createQueryBuilder('u')
            ->where('u.name = :name OR u.email = :email')
            ->setParameter('name', $username)
            ->setParameter('email', $username)
            ->getQuery()
            ->getOneOrNullResult();

        return $user;
    }
}
