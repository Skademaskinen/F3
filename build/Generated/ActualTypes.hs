-- This file is auto generated and will be overriden regulary. Please edit `Application/Schema.sql` to change the Types\n"
{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, InstanceSigs, MultiParamTypeClasses, TypeFamilies, DataKinds, TypeOperators, UndecidableInstances, ConstraintKinds, StandaloneDeriving  #-}
{-# OPTIONS_GHC -Wno-unused-imports -Wno-dodgy-imports -Wno-unused-matches #-}
module Generated.ActualTypes (module Generated.ActualTypes, module Generated.Enums) where
import IHP.HaskellSupport
import IHP.ModelSupport
import CorePrelude hiding (id)
import Data.Time.Clock
import Data.Time.LocalTime
import qualified Data.Time.Calendar
import qualified Data.List as List
import qualified Data.ByteString as ByteString
import qualified Net.IP
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField hiding (Field, name)
import Database.PostgreSQL.Simple.ToField hiding (Field)
import qualified IHP.Controller.Param
import GHC.TypeLits
import Data.UUID (UUID)
import Data.Default
import qualified IHP.QueryBuilder as QueryBuilder
import qualified Data.Proxy
import GHC.Records
import Data.Data
import qualified Data.String.Conversions
import qualified Data.Text.Encoding
import qualified Data.Aeson
import Database.PostgreSQL.Simple.Types (Query (Query), Binary ( .. ))
import qualified Database.PostgreSQL.Simple.Types
import IHP.Job.Types
import IHP.Job.Queue ()
import qualified Control.DeepSeq as DeepSeq
import qualified Data.Dynamic
import Data.Scientific
import Generated.Enums
data Click'  = Click {id :: (Id' "clicks"), ip :: Text, timestamp :: Text, meta :: MetaBag} deriving (Eq, Show)

type instance PrimaryKey "clicks" = Int

type Click = Click' 

type instance GetTableName (Click' ) = "clicks"
type instance GetModelByTableName "clicks" = Click

instance Default (Id' "clicks") where def = Id def

instance () => Table (Click' ) where
    tableName = "clicks"
    tableNameByteString = Data.Text.Encoding.encodeUtf8 "clicks"
    columnNames = ["id","ip","timestamp"]
    primaryKeyColumnNames = ["id"]
    primaryKeyConditionForId (Id (id)) = toField id
    {-# INLINABLE primaryKeyConditionForId #-}


