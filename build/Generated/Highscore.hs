-- This file is auto generated and will be overriden regulary. Please edit `Application/Schema.sql` to change the Types\n"
{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, InstanceSigs, MultiParamTypeClasses, TypeFamilies, DataKinds, TypeOperators, UndecidableInstances, ConstraintKinds, StandaloneDeriving  #-}
{-# OPTIONS_GHC -Wno-unused-imports -Wno-dodgy-imports -Wno-unused-matches #-}
module Generated.Highscore where
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
import Generated.ActualTypes
instance InputValue Highscore where inputValue = IHP.ModelSupport.recordToInputValue


instance FromRow Highscore where
    fromRow = do
        id <- field
        let theRecord = Highscore id def { originalDatabaseRecord = Just (Data.Dynamic.toDyn theRecord) }
        pure theRecord


type instance GetModelName (Highscore' ) = "Highscore"

instance CanCreate Highscore where
    create :: (?modelContext :: ModelContext) => Highscore -> IO Highscore
    create model = do
        sqlQuerySingleRow "INSERT INTO highscores (id) VALUES (?) RETURNING id" (Only (fieldWithDefault #id model))
    createMany [] = pure []
    createMany models = do
        sqlQuery (Query $ "INSERT INTO highscores (id) VALUES " <> (ByteString.intercalate ", " (List.map (\_ -> "(?)") models)) <> " RETURNING id") (List.concat $ List.map (\model -> [toField (fieldWithDefault #id model)]) models)

instance CanUpdate Highscore where
    updateRecord model = do
        sqlQuerySingleRow "UPDATE highscores SET id = ? WHERE id = ? RETURNING id" ((fieldWithUpdate #id model, model.id))
    updateRecordDiscardResult model = do
        sqlExecDiscardResult "UPDATE highscores SET id = ? WHERE id = ?" ((fieldWithUpdate #id model, model.id))

instance Record Highscore where
    {-# INLINE newRecord #-}
    newRecord = Highscore def  def


instance QueryBuilder.FilterPrimaryKey "highscores" where
    filterWhereId id builder =
        builder |> QueryBuilder.filterWhere (#id, id)
    {-# INLINE filterWhereId #-}


instance SetField "id" (Highscore' ) (Id' "highscores") where
    {-# INLINE setField #-}
    setField newValue (Highscore id meta) =
        Highscore newValue (meta { touchedFields = "id" : touchedFields meta })
instance SetField "meta" (Highscore' ) MetaBag where
    {-# INLINE setField #-}
    setField newValue (Highscore id meta) =
        Highscore id newValue
instance UpdateField "id" (Highscore' ) (Highscore' ) (Id' "highscores") (Id' "highscores") where
    {-# INLINE updateField #-}
    updateField newValue (Highscore id meta) = Highscore newValue (meta { touchedFields = "id" : touchedFields meta })
instance UpdateField "meta" (Highscore' ) (Highscore' ) MetaBag MetaBag where
    {-# INLINE updateField #-}
    updateField newValue (Highscore id meta) = Highscore id newValue


