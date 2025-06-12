/*
  Warnings:

  - You are about to drop the column `role` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `User` table. All the data in the column will be lost.
  - Added the required column `curso` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `plan` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "User_username_key";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "role",
DROP COLUMN "username",
ADD COLUMN     "curso" TEXT NOT NULL,
ADD COLUMN     "plan" TEXT NOT NULL;
